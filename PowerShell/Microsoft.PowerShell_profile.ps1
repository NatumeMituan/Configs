if ($Host.UI.RawUI) {
    # Dot source additional profile scripts
    . (Join-Path $PSScriptRoot "functions.ps1")
    . (Join-Path $PSScriptRoot "aliases.ps1")
    . (Join-Path $PSScriptRoot "settings.ps1")
}
