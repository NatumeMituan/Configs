# Function to check if a command is available
. (Join-Path $PSScriptRoot "utils.ps1")

$prerequisites = @(
    @{
        # https://scoop.sh/
        # https://github.com/ScoopInstaller/Scoop
        name = "scoop"
        install = {
            Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
            Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
        }
    }
)

$tools = @(
    @{
        # https://github.com/g0t4/pwsh-abbr
        # https://www.powershellgallery.com/packages/Abbr
        name = "abbr"
        install = { Install-Module -Name Abbr }
    },
    @{
        # https://www.autohotkey.com/
        # https://github.com/AutoHotkey/AutoHotkey
        name = "autohotkey"
        install = { scoop install main/autohotkey }
    },
    @{
        # https://github.com/sharkdp/bat
        name = "bat"
        install = { scoop install main/bat }
        config = {
            # https://github.com/catppuccin/bat?tab=readme-ov-file#usage
            wget --no-verbose -O "$(bat --config-dir)/themes/Catppuccin Macchiato.tmTheme" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Macchiato.tmTheme
            bat cache --build
        }
    },
    @{
        # https://github.com/eza-community/eza
        name = "eza"
        install = { scoop install main/eza }
    },
    @{
        # https://github.com/sharkdp/fd
        name = "fd"
        install = { scoop install main/fd }
    },
    @{
        # https://junegunn.github.io/fzf/
        # https://github.com/junegunn/fzf
        name = "fzf"
        install = { scoop install main/fzf }
    },
    @{
        # https://github.com/gerardog/gsudo
        name = "gsudo"
        install = { scoop install main/gsudo }
    },
    @{
        # https://github.com/kelleyma49/PSFzf
        name = "Invoke-Fzf"
        install = { scoop install extras/psfzf }
    },
    @{
        # https://github.com/jesseduffield/lazygit
        name = "lazygit"
        install = { scoop install extras/lazygit }
        configPath = Join-Path "$env:LOCALAPPDATA" "lazygit"
    },
    @{
        # https://www.greenwoodsoftware.com/less
        name = "less"
        install = { scoop install main/less }
    },
    @{
        # https://www.mingw-w64.org/
        name = "gcc"
        install = { scoop install main/mingw }
    },
    @{
        # https://neovim.io/
        # https://github.com/neovim/neovim.github.io/
        name = "nvim"
        install = { scoop install main/neovim }
        configPath = (Join-Path "$env:LOCALAPPDATA" "nvim")
    },
    @{
        # https://github.com/jandedobbeleer/oh-my-posh
        # Only winget and the Windows Store add the environment variable POSH_THEMES_PATH automatically
        name = "oh-my-posh"
        install = { winget install JanDeDobbeleer.OhMyPosh -s winget }
    },
    @{
        # https://github.com/BurntSushi/ripgrep
        name = "rg"
        install = { scoop install main/ripgrep }
    },
    @{
        # https://github.com/tldr-pages/tlrc
        name = "tldr"
        install = { scoop install main/tlrc }
    },
    @{
        # https://eternallybored.org/misc/wget/
        name = "wget"
        install = { scoop install main/wget }
    },
    @{
        # https://yazi-rs.github.io/
        # https://github.com/sxyazi/yazi
        name = "yazi"
        install = { scoop install main/yazi }
        config = {
            # flavors (themes)
            # https://yazi-rs.github.io/docs/flavors/overview/
            # https://github.com/yazi-rs/flavors/tree/main/catppuccin-macchiato.yazi
            # https://github.com/yazi-rs/flavors/tree/main/catppuccin-latte.yazi
            ya pack -a yazi-rs/flavors:catppuccin-latte
            ya pack -a yazi-rs/flavors:catppuccin-macchiato

            # smart-enter plugin
            # https://github.com/yazi-rs/plugins/tree/main/smart-enter.yazi
            ya pack -a yazi-rs/plugins:smart-enter
        }
        configPath = (Join-Path "$env:APPDATA" "yazi")
    },
    @{
        # https://github.com/ajeetdsouza/zoxide
        name = "zoxide"
        install = { scoop install main/zoxide }
    }
)

Install-Tools -tools $prerequisites
Install-Tools -tools $tools
Setup-Configs -tools $tools
