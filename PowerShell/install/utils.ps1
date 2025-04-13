function Is-CommandAvailable {
    param ([string]$cmd)
    return [bool](Get-Command $cmd -ErrorAction SilentlyContinue)
}

function Install-Tools {
    param ([array]$tools)
    foreach ($tool in $tools) {
        $name = $tool.name
        $install = $tool.install
        if (-not (Is-CommandAvailable $name)) {
            Write-Host "$name is not available. Installing..." -ForegroundColor Yellow
            & $install
            Write-Host "$name installed." -ForegroundColor Green
        } else {
            Write-Host "$name is already installed." -ForegroundColor Cyan
        }
    }
}

function Setup-Configs {
    param ([array]$tools)

    $targetRoot = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)

    foreach ($tool in $tools) {
        if ($tool.configPath) {
            $targetPath = Join-Path $targetRoot $tool.name

            Link-ConfigDirectory -name $tool.name -configPath $tool.configPath -targetPath $targetPath
        }
    }
}

function Link-ConfigDirectory {
    param (
        [string]$name,
        [string]$configPath,
        [string]$targetPath
    )

    # Backup the config directory if it exists and not a link
    if ((Test-Path $configPath) -and -not ((Get-Item $configPath).Attributes -contains 'ReparsePoint')) {
        $timestamp = Get-Date -Format "yyyyMMddHHmmss"
        $backupPath = "$configPath.bak.$timestamp"
        Move-Item -Path $configPath -Destination $backupPath
        Write-Host "[$name]: Existing config directory backed up to $backupPath" -ForegroundColor Yellow
    }

    # Create symbolic link to the config directory
    New-Item -ItemType SymbolicLink -Path $configPath -Target $targetPath -Force | Out-Null

    # Exit if the symbolic link creation fails
    if (-not $?) {
        Write-Host "[$name]: Failed to create symbolic link from $configPath to $targetPath." -ForegroundColor Red
        exit 1
    } 
    
    Write-Host "[$name]: Created symbolic link from $configPath to $targetPath." -ForegroundColor Blue
}