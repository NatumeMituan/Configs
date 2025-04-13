# yazi
# https://yazi-rs.github.io/
# https://github.com/sxyazi/yazi

# Install
scoop install main/yazi

# Backup the config directory if it exists
$yaziConfigDir = Join-Path "$env:APPDATA" "yazi"
if (Test-Path $yaziConfigDir) {
    $timestamp = Get-Date -Format "yyyyMMddHHmmss"
    $backupDir = "$yaziConfigDir.bak.$timestamp"
    Move-Item -Path $yaziConfigDir -Destination $backupDir
    Write-Host "[yazi]: Existing config directory backed up to $backupDir" -ForegroundColor Yellow
}

# Create symbolic link to the config directory
$targetPath = Join-Path (Split-Path -Parent (Split-Path -Parent $PSScriptRoot)) "yazi"

New-Item -ItemType SymbolicLink -Path $yaziConfigDir -Target $targetPath

# Exit if the symbolic link creation fails
if (-not $?) {
    Write-Host "[yazi]: Failed to create symbolic link from $yaziConfigDir to $targetPath." -ForegroundColor Red
    exit 1
}

Write-Host "[yazi]: Created symbolic link from $yaziConfigDir to $targetPath." -ForegroundColor Blue

# file.exe
# https://yazi-rs.github.io/docs/installation/#windows
$envKey = "YAZI_FILE_ONE"
$envValue = "$Env:GIT_INSTALL_ROOT\usr\bin\file.exe"
[Environment]::SetEnvironmentVariable($envKey, $envValue, 'User')
Write-Host "[yazi]: Environment variable $envKey set to $envValue." -ForegroundColor Blue

# flavors (themes)
# https://yazi-rs.github.io/docs/flavors/overview/
# https://github.com/yazi-rs/flavors/tree/main/catppuccin-macchiato.yazi
# https://github.com/yazi-rs/flavors/tree/main/catppuccin-latte.yazi
ya pack -a yazi-rs/flavors:catppuccin-macchiato
ya pack -a yazi-rs/flavors:catppuccin-latte