function tk {
    mkdir -f $args[0] && cd $args[0]
}

function rm-rf {
    Remove-Item -Recurse -Force $args
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

# git
function gs {
    git status $args
}

function glg {
    git log $args
}

function glo {
    git log --oneline --decorate=no $args
}

function gsw {
    git switch $args
}

function gb {
    git branch $args
}

function gcl {
    git clean $args
}

function ga {
    git add $args
}

function gco {
    git commit $args
}

function gca { # commit all
    git add -A; git commit $args
}

function gph {
    git push $args
}

function gpl {
    git pull $args
}

function gd {
    git diff $args
}

# eza
# https://github.com/eza-community/eza
# scoop install main/eza
function l {
    eza --group-directories-last $args
}

function ll {
    eza --long --group-directories-last $args
}

function la {
    eza --all --long --group-directories-last $args
}

function li {
    eza --icons --group-directories-last $args
}

function lai {
    eza --all --long --icons --group-directories-last $args
}

function lt {
    eza --tree --group-directories-last $args
}