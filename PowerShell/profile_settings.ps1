# bat
# https://github.com/catppuccin/bat
$ENV:BAT_THEME = "Catppuccin Macchiato"

# oh-my-posh
# https://ohmyposh.dev/docs/installation/prompt
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\powerlevel10k_rainbow.omp.json" | Invoke-Expression

# PSReadLine
# https://github.com/PowerShell/PSReadLine
# https://learn.microsoft.com/en-us/powershell/module/psreadline/about/about_psreadline
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadlineKeyHandler -Key Ctrl+d -Function ViExit

# PSFzf
# https://github.com/kelleyma49/PSFzf?tab=readme-ov-file#psreadline-integration
# Get-PSReadLineKeyHandler | grep "fzf"
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'

# yazi
# file.exe
# https://yazi-rs.github.io/docs/installation/#windows
$ENV:YAZI_FILE_ONE = "$Env:GIT_INSTALL_ROOT\usr\bin\file.exe"

# zoxide
# https://github.com/ajeetdsouza/zoxide?tab=readme-ov-file#installation
Invoke-Expression (& { (zoxide init powershell | Out-String) })
