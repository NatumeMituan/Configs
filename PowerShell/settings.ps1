# SHELL

# For FZF_CTRL_R_OPTS
$ENV:SHELL = "pwsh"

# bat
# https://github.com/catppuccin/bat
$ENV:BAT_THEME = "Catppuccin Macchiato"

# eza
# https://github.com/ajeetdsouza/zoxide?tab=readme-ov-file#environment-variables
# options to pass to fzf, ignoring the frecency score, which is {1}
$ENV:_ZO_FZF_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'eza --tree --all --level=2 --color=always --icons {2}'"

# fzf

# https://github.com/catppuccin/fzf?tab=readme-ov-file#usage
$ENV:FZF_DEFAULT_OPTS=@"
--color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796
--color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6
--color=marker:#b7bdf8,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796
--color=selected-bg:#494d64
--color=border:#363a4f,label:#cad3f5
"@

# https://github.com/junegunn/fzf?tab=readme-ov-file#key-bindings-for-command-line
# - preview with no decoration but number, and color
# - <C-/> to cycle through how preview windows is displayed
$ENV:FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

$ENV:FZF_CTRL_R_OPTS="
  --bind 'ctrl-y:execute-silent(echo {} | Set-Clipboard)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"

$ENV:FZF_ALT_C_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'eza --tree --all --level=2 --color=always --icons {}'"

# oh-my-posh
# https://ohmyposh.dev/docs/installation/prompt
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\powerlevel10k_rainbow.omp.json" | Invoke-Expression

# PSReadLine
# https://github.com/PowerShell/PSReadLine
# https://learn.microsoft.com/en-us/powershell/module/psreadline/about/about_psreadline
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadlineKeyHandler -Key Ctrl+d -Function ViExit
Set-PSReadlineKeyHandler -Key Ctrl+k -Function PreviousHistory
Set-PSReadlineKeyHandler -Key Ctrl+j -Function NextHistory
Set-PSReadlineKeyHandler -Key Ctrl+g -ScriptBlock{
    [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
    [Microsoft.PowerShell.PSConsoleReadLine]::Insert('lazygit')
    [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}

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
