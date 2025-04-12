# yazi
# https://yazi-rs.github.io/
# https://github.com/sxyazi/yazi

# install
scoop install main/yazi

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
$yaziConfigDir = Join-Path "$env:APPDATA" "yazi" "config"
mkdir $yaziConfigDir -Force | Out-Null
$themeConfigFile = Join-Path $yaziConfigDir "theme.toml"

# Backup existing theme.toml if it exists
if (Test-Path $themeConfigFile) {
    $timestamp = Get-Date -Format "yyyyMMddHHmmss"
    $backupFile = "$themeConfigFile.bak.$timestamp"
    Copy-Item -Path $themeConfigFile -Destination $backupFile
    Write-Host "[yazi]: Existing theme.toml backed up to $backupFile" -ForegroundColor Yellow
}

# Set the content of theme.toml
@"
[flavor]
dark = "catppuccin-macchiato"
light = "catppuccin-latte"
"@ | Set-Content -Path $themeConfigFile -Encoding UTF8
Write-Host "[yazi]: Flavors set." -ForegroundColor Blue