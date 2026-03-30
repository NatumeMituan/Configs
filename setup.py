import os
import sys
import platform
import subprocess
import tomllib
import argparse
import shutil
from pathlib import Path

# ─────────────────────────────────────────────────────────────────────
# Colored Logging
# ─────────────────────────────────────────────────────────────────────

RESET = "\033[0m"
BLUE = "\033[34m"
YELLOW = "\033[33m"
RED = "\033[31m"
GREEN = "\033[32m"
MAGENTA = "\033[35m"


def info(msg): print(f"{BLUE}[INFO]{RESET} {msg}")
def warn(msg): print(f"{YELLOW}[WARN]{RESET} {msg}")
def error(msg): print(f"{RED}[ERROR]{RESET} {msg}")
def success(msg): print(f"{GREEN}[OK]{RESET} {msg}")
def shell(msg): print(f"{MAGENTA}$ {msg}{RESET}")


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


def run_command_interactive(platform, cmd, description=None, dry_run=False):
    if description:
        info(description)
    shell(cmd)

    if dry_run:
        return

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
        name = pkg["name"]
        if isinstance(name, dict):
            name = name.get("default", name)
        return pkg["install"], name

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


def link_dotfiles(pkg, platform, root_dir, dry_run=False):
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

    if dry_run:
        info(f"Would link: {src} → {dest}")
        return

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


def unlink_dotfiles(pkg, platform):
    name = pkg["name"] if isinstance(
        pkg["name"], str) else pkg["name"].get("default")
    if not name:
        return

    has_dotfile = pkg.get("dotfile", False)
    has_destination = "destination" in pkg
    if not has_dotfile and not has_destination:
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

    if dest.is_symlink():
        dest.unlink()
        success(f"Unlinked: {dest}")
    elif dest.exists():
        warn(f"Not a symlink, skipping: {dest}")
    else:
        info(f"Nothing to unlink: {dest}")


# ─────────────────────────────────────────────────────────────────────
# Dependencies (git repos & file downloads)
# ─────────────────────────────────────────────────────────────────────


def resolve_dest_path(dest_str, platform):
    """Expand shell expressions like $(cmd) and environment variables."""
    if "$(" in dest_str:
        shell_runner = get_shell_runner(platform)
        echo_cmd = f'echo "{dest_str}"'
        result = subprocess.run(
            shell_runner + [echo_cmd],
            capture_output=True, text=True, check=True,
        )
        return Path(result.stdout.strip())

    return Path(os.path.expandvars(os.path.expanduser(dest_str)))


def fetch_dependencies(pkg, platform, name, dry_run=False):
    deps = pkg.get("dependency", [])
    if not deps:
        return

    for dep in deps:
        only = dep.get("only")
        if only:
            if isinstance(only, str):
                only = [only]
            if platform not in only:
                continue

        exclude = dep.get("exclude")
        if exclude:
            if isinstance(exclude, str):
                exclude = [exclude]
            if platform in exclude:
                continue

        url = dep["url"]
        dest = resolve_dest_path(dep["dest"], platform)
        dep_type = dep.get("type", "git")
        ref = dep.get("ref")

        if dep_type == "git":
            if dry_run:
                info(f"Would clone {url} → {dest}")
                continue

            info(f"Fetching git dependency for {name}: {url}")
            if dest.exists():
                shutil.rmtree(dest)
            cmd = ["git", "clone"]
            if ref:
                cmd += ["-b", ref]
            cmd += [url, str(dest)]
            dest.parent.mkdir(parents=True, exist_ok=True)
            shell(" ".join(cmd))
            subprocess.run(cmd, check=True)
            success(f"Cloned: {url} → {dest}")

        elif dep_type == "file":
            if dry_run:
                info(f"Would download {url} → {dest}")
                continue

            info(f"Downloading dependency for {name}: {url}")
            dest.parent.mkdir(parents=True, exist_ok=True)
            if dest.exists():
                dest.unlink()
            from urllib.request import urlretrieve
            shell(f"urlretrieve({url}, {dest})")
            urlretrieve(url, dest)
            success(f"Downloaded: {url} → {dest}")


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


def run_config_commands(pkg, platform, name, dry_run=False):
    cmds = resolve_config_prerequisite(pkg, platform)
    if cmds:
        for cmd in cmds:
            run_command_interactive(
                platform, cmd, f"Running config prerequisite for {name}",
                dry_run=dry_run)

    cmds = resolve_config_commands(pkg, platform)
    if cmds:
        for cmd in cmds:
            run_command_interactive(
                platform, cmd, f"Running config for {name}",
                dry_run=dry_run)


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
# List Packages
# ─────────────────────────────────────────────────────────────────────


def list_packages(packages, platform):
    for pkg in packages:
        name = resolve_package_name(pkg, None)
        applicable = should_install_package(pkg, platform)
        has_dotfile = pkg.get("dotfile", False) or "destination" in pkg
        has_config = pkg.get("config") or pkg.get("config_prerequisite")
        has_deps = bool(pkg.get("dependency"))

        tags = []
        if has_dotfile:
            tags.append("dotfile")
        if has_config:
            tags.append("config")
        if has_deps:
            tags.append("deps")
        if not applicable:
            tags.append("skipped")

        tag_str = f"  [{', '.join(tags)}]" if tags else ""
        marker = f"{GREEN}●{RESET}" if applicable else f"{YELLOW}○{RESET}"
        print(f"  {marker} {name}{tag_str}")


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
    parser.add_argument(
        "--config-only",
        action="store_true",
        help="Only link dotfiles and run config commands, skip installation.",
    )
    parser.add_argument(
        "--list",
        action="store_true",
        help="List available packages and exit.",
    )
    parser.add_argument(
        "--dry-run",
        action="store_true",
        help="Preview actions without executing.",
    )
    parser.add_argument(
        "--continue-on-error",
        action="store_true",
        help="Continue processing remaining packages on error.",
    )
    parser.add_argument(
        "--unlink",
        action="store_true",
        help="Remove dotfile symlinks.",
    )
    args = parser.parse_args()

    root_dir = Path(__file__).parent
    plat = detect_platform()
    config = load_config(root_dir / "setup.toml")

    installers = config.get("installer", {})
    packages = config.get("package", [])

    info(f"Detected platform: {plat}")

    if args.list:
        list_packages(packages, plat)
        return

    if args.package:
        packages = [pkg for pkg in packages if resolve_package_name(
            pkg, None) == args.package]
        if not packages:
            error(f"Package '{args.package}' not found in configuration.")
            sys.exit(1)

    failures = []

    for pkg in packages:
        if not should_install_package(pkg, plat):
            info(f"Skipping {pkg.get('name')} (filtered by platform)")
            continue

        name = resolve_package_name(
            pkg, resolve_installer(pkg, plat, installers))

        if args.unlink:
            unlink_dotfiles(pkg, plat)
            continue

        # Install
        if not args.config_only:
            try:
                cmd, name = build_install_command(pkg, plat, installers)
                run_command_interactive(
                    plat, cmd, f"Installing {name}", dry_run=args.dry_run)
            except Exception as e:
                error(f"Installation failed for {name}: {e}")
                if args.continue_on_error:
                    failures.append((name, "install", e))
                    continue
                sys.exit(1)

        # Link dotfiles
        try:
            link_dotfiles(pkg, plat, root_dir, dry_run=args.dry_run)
        except Exception as e:
            error(f"Dotfile linking failed for {name}: {e}")
            if args.continue_on_error:
                failures.append((name, "link", e))
                continue
            sys.exit(1)

        # Fetch dependencies
        try:
            fetch_dependencies(pkg, plat, name, dry_run=args.dry_run)
        except Exception as e:
            error(f"Dependency fetch failed for {name}: {e}")
            if args.continue_on_error:
                failures.append((name, "dependency", e))
                continue
            sys.exit(1)

        # Config commands
        if not args.config_only or pkg.get("config") or pkg.get("config_prerequisite"):
            try:
                run_config_commands(pkg, plat, name, dry_run=args.dry_run)
            except Exception as e:
                error(f"Config command failed for {name}: {e}")
                if args.continue_on_error:
                    failures.append((name, "config", e))
                    continue
                sys.exit(1)

    if failures:
        print()
        error(f"{len(failures)} failure(s):")
        for name, stage, e in failures:
            error(f"  {name} ({stage}): {e}")
        sys.exit(1)


if __name__ == "__main__":
    main()
