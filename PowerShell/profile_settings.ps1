# PSReadLine
# https://github.com/PowerShell/PowerShell
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

# oh-my-posh
# https://github.com/jandedobbeleer/oh-my-posh
# https://ohmyposh.dev/docs/installation/prompt
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\powerlevel10k_rainbow.omp.json" | Invoke-Expression

# zoxide
# https://github.com/ajeetdsouza/zoxide
# scoop install main/zoxide
Invoke-Expression (& { (zoxide init powershell | Out-String) })

# CompletionPredictor
# https://github.com/PowerShell/CompletionPredictor
# https://learn.microsoft.com/en-us/powershell/scripting/learn/shell/using-predictors
# Install-Module -Name CompletionPredictor -Repository PSGallery
Import-Module CompletionPredictor
