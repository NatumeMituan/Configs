# yazi
# https://yazi-rs.github.io/
# https://github.com/sxyazi/yazi

# Install
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