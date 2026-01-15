function take {
    mkdir -f $args[0] && cd $args[0]
}

function grep($pattern) {
    $input | Out-String -Stream | Select-String $pattern
}

function what {
    $command = Get-Command $args
    if ($command.CommandType -eq 'Alias') {
        $commandDefinition = Get-Command $command.Definition
        $commandDefinition.Definition
    } else {
        $command.Definition
    }
}

# opencode
function oc {
    $oldShell = $env:SHELL
    $oldGitBash = $env:OPENCODE_GIT_BASH_PATH
    try {
        $git = Get-Command git -ErrorAction SilentlyContinue
        if ($git) {
            $gitDir = Split-Path -Parent $git.Path
            if ($gitDir -eq (Join-Path $env:USERPROFILE "scoop\shims")) {
                $bash = Join-Path $gitDir "bash.exe"
                if (Test-Path $bash) { $env:OPENCODE_GIT_BASH_PATH = $bash }
            }
            if ($null -eq $env:OPENCODE_GIT_BASH_PATH) {
                $bash = Join-Path (Split-Path -Parent $gitDir) "bin\bash.exe"
                if (Test-Path $bash) { $env:OPENCODE_GIT_BASH_PATH = $bash }
            }
        }
        Remove-Item Env:SHELL -ErrorAction SilentlyContinue
        opencode @args
    } finally {
        if ($null -eq $oldShell) { Remove-Item Env:SHELL -ErrorAction SilentlyContinue } else { $env:SHELL = $oldShell }
        if ($null -eq $oldGitBash) { Remove-Item Env:OPENCODE_GIT_BASH_PATH -ErrorAction SilentlyContinue } else { $env:OPENCODE_GIT_BASH_PATH = $oldGitBash }
    }

}

# yazi
function y {
    $tmp = [System.IO.Path]::GetTempFileName()
    yazi $args --cwd-file="$tmp"
    $cwd = Get-Content -Path $tmp -Encoding UTF8
    if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path) {
        Set-Location -LiteralPath ([System.IO.Path]::GetFullPath($cwd))
    }
    Remove-Item -Path $tmp
}
