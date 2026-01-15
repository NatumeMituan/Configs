import os
import sys
import platform
import subprocess
import tomllib
import argparse
from pathlib import Path

from colorama import init, Fore, Style

init()


# ─────────────────────────────────────────────────────────────────────
# Colored Logging
# ─────────────────────────────────────────────────────────────────────


def info(msg): print(f"{Fore.BLUE}[INFO]{Style.RESET_ALL} {msg}")
def warn(msg): print(f"{Fore.YELLOW}[WARN]{Style.RESET_ALL} {msg}")
def error(msg): print(f"{Fore.RED}[ERROR]{Style.RESET_ALL} {msg}")
def success(msg): print(f"{Fore.GREEN}[OK]{Style.RESET_ALL} {msg}")
def shell(msg): print(f"{Fore.MAGENTA}$ {msg}{Style.RESET_ALL}")


# ─────────────────────────────────────────────────────────────────────
# Platform Detection
# ─────────────────────────────────────────────────────────────────────


def detect_platform():
    system = platform.system().lower()

    if system == "windows":
        return "windows"
    elif system == "darwin":
        return "macos"
    elif system == "linux":
        try:
            with open("/etc/os-release") as f:
                for line in f:
                    if line.startswith("ID="):
                        return line.strip().split("=")[1].strip('"').lower()
        except FileNotFoundError:
            pass
        return "linux"
    else:
        raise RuntimeError(f"Unsupported system: {system}")


# ─────────────────────────────────────────────────────────────────────
# Command Execution
# ─────────────────────────────────────────────────────────────────────


def get_shell_runner(platform):
    if platform == "windows":
        return ["pwsh", "-NoProfile", "-Command"]
    else:
        return ["bash", "-c"]


def run_command_interactive(platform, cmd, description=None):
    if description:
        info(description)
    shell(cmd)

    shell_runner = get_shell_runner(platform)

    env = None
    if platform == "ubuntu":
        env = os.environ.copy()
        env["PATH"] = "/home/linuxbrew/.linuxbrew/bin:" + env["PATH"]

    subprocess.run(
        shell_runner + [cmd],
        check=True,
        shell=False,
        env=env,
        stdin=sys.stdin,
        stdout=sys.stdout,
        stderr=sys.stderr,
    )


# ─────────────────────────────────────────────────────────────────────
# Config Loader
# ─────────────────────────────────────────────────────────────────────


def load_config(path="setup.toml"):
    with open(path, "rb") as f:
        return tomllib.load(f)


# ─────────────────────────────────────────────────────────────────────
# Installer & Package Resolution
# ─────────────────────────────────────────────────────────────────────


def resolve_installer(pkg, platform, installers):
    return pkg.get("installer", {}).get(platform, installers.get(platform))


def resolve_package_name(pkg, installer):
    if isinstance(pkg["name"], str):
        return pkg["name"]
    return pkg["name"].get(installer, pkg["name"].get("default", None))


def build_install_command(pkg, platform, installers):
    if "install" in pkg:
        return pkg["install"], pkg.get("name")

    installer = resolve_installer(pkg, platform, installers)
    if not installer:
        raise ValueError(f"No installer defined for platform {platform}")

    name = resolve_package_name(pkg, installer)
    if not name:
        raise ValueError(f"No name defined for installer {installer}")

    # Installer-specific command logic
    match installer:
        case "apt":
            return f"sudo apt-get install {name}", name
        case "brew":
            return f"brew install {name}", name
        case "scoop":
            return f"scoop install {name}", name
        case _:
            return f"{installer} install {name}", name


# ─────────────────────────────────────────────────────────────────────
# Dotfile Linking
# ─────────────────────────────────────────────────────────────────────


def link_dotfiles(pkg, platform, root_dir):
    name = pkg["name"] if isinstance(
        pkg["name"], str) else pkg["name"].get("default")
    if not name:
        return

    has_dotfile = pkg.get("dotfile", False)
    has_destination = "destination" in pkg
    if not has_dotfile and not has_destination:
        return

    src = root_dir / name
    if not src.exists():
        warn(f"Dotfile source not found: {src}")
        return

    if has_destination and platform in pkg["destination"]:
        env_key = pkg["destination"][platform]
        path = os.path.expandvars(env_key)
        dest = Path(path)
    else:
        if platform == "windows":
            dest = Path(os.environ.get("APPDATA", Path.home())) / name
        else:
            dest = Path.home() / ".config" / name

    dest.parent.mkdir(parents=True, exist_ok=True)

    if dest.exists():
        if dest.is_symlink():
            dest.unlink()
        else:
            backup_path = dest.with_suffix(".backup")
            warn(
                f"Destination exists and is not a symlink. Backing up to: {
                    backup_path}"
            )
            dest.rename(backup_path)

    try:
        os.symlink(src, dest, target_is_directory=True)
    except FileExistsError:
        os.remove(dest)
        os.symlink(src, dest, target_is_directory=True)
    success(f"Linked dotfile: {src} → {dest}")


# ─────────────────────────────────────────────────────────────────────
# Config Commands
# ─────────────────────────────────────────────────────────────────────


def resolve_config_prerequisite(pkg, platform):
    cmds = pkg.get("config_prerequisite")

    if isinstance(cmds, dict):
        cmds = cmds.get(platform, cmds.get("default", None))

    if isinstance(cmds, str):
        cmds = [cmds]

    return cmds


def resolve_config_commands(pkg, platform):
    cmds = pkg.get("config")

    if isinstance(cmds, dict):
        cmds = cmds.get(platform, None)

    if isinstance(cmds, str):
        cmds = [cmds]

    return cmds


def run_config_commands(pkg, platform, name):
    cmds = resolve_config_prerequisite(pkg, platform)
    if cmds:
        for cmd in cmds:
            run_command_interactive(
                platform, cmd, f"Running config prerequisite for {name}")

    cmds = resolve_config_commands(pkg, platform)
    if cmds:
        for cmd in cmds:
            run_command_interactive(
                platform, cmd, f"Running config for {name}")


# ─────────────────────────────────────────────────────────────────────
# Platform Filters
# ─────────────────────────────────────────────────────────────────────


def should_install_package(pkg, platform):
    if "only" in pkg:
        only = pkg["only"]
        if isinstance(only, str):
            only = [only]
        return platform in only
    if "exclude" in pkg:
        exclude = pkg["exclude"]
        if isinstance(exclude, str):
            exclude = [exclude]
        return platform not in exclude
    return True


# ─────────────────────────────────────────────────────────────────────
# Main Logic
# ─────────────────────────────────────────────────────────────────────


def main():
    parser = argparse.ArgumentParser(
        description="Setup script for installing packages.")
    parser.add_argument(
        "--package",
        type=str,
        help="Specify a single package to install by name.",
    )
    args = parser.parse_args()

    root_dir = Path(__file__).parent
    platform = detect_platform()
    config = load_config(root_dir / "setup.toml")

    installers = config.get("installer", {})
    packages = config.get("package", [])

    info(f"Detected platform: {platform}")

    if args.package:
        packages = [pkg for pkg in packages if resolve_package_name(
            pkg, None) == args.package]
        if not packages:
            error(f"Package '{args.package}' not found in configuration.")
            sys.exit(1)

    for pkg in packages:
        if not should_install_package(pkg, platform):
            info(f"Skipping {pkg.get('name')} (filtered by platform)")
            continue

        try:
            cmd, name = build_install_command(pkg, platform, installers)
            run_command_interactive(platform, cmd, f"Installing {name}")
        except Exception as e:
            error(f"Installation failed for {name}: {e}")
            sys.exit(1)  # Stop execution on error

        try:
            link_dotfiles(pkg, platform, root_dir)
        except Exception as e:
            error(f"Dotfile linking failed: {e}")
            sys.exit(1)  # Stop execution on error

        try:
            run_config_commands(pkg, platform, name)
        except Exception as e:
            error(f"Config command failed: {e}")
            sys.exit(1)  # Stop execution on error


if __name__ == "__main__":
    main()
