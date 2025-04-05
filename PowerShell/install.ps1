# Function to check if a command is available
function Is-CommandAvailable {
    param ([string]$cmd)
    return [bool](Get-Command $cmd -ErrorAction SilentlyContinue)
}

# Loop through each tool and check if it's available, install if not
function Install-Tools {
    param ([hashtable]$tools)
    foreach ($tool in $tools.Keys) {
        if (-not (Is-CommandAvailable $tool)) {
            Write-Host "$tool is not available. Installing..." -ForegroundColor Yellow
            & $tools[$tool]
            Write-Host "$tool installed." -ForegroundColor Green
        } else {
            Write-Host "$tool is already installed." -ForegroundColor Cyan
        }
    }
}

$prerequisites = @{
    # https://scoop.sh/
    # https://github.com/ScoopInstaller/Scoop
    "scoop" = {
        Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
        Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
    }
}

$tools = @{
    # https://github.com/g0t4/pwsh-abbr
    # https://www.powershellgallery.com/packages/Abbr
    "abbr" = { Install-Module -Name Abbr }

    # https://github.com/eza-community/eza
    "eza" = { scoop install main/eza }

    # https://github.com/gerardog/gsudo
    "gsudo" = { scoop install main/gsudo }

    # https://github.com/jandedobbeleer/oh-my-posh
    # Only winget and the Windows Store add the environment variable POSH_THEMES_PATH automatically
    "oh-my-posh" = { winget install JanDeDobbeleer.OhMyPosh -s winget }

    # https://github.com/ajeetdsouza/zoxide
    "zoxide" = { scoop install main/zoxide }
}

Install-Tools -tools $prerequisites
Install-Tools -tools $tools