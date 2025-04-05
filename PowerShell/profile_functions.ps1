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