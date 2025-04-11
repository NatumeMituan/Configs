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