# zoxide
# https://github.com/ajeetdsouza/zoxide
Invoke-Expression (& { (zoxide init powershell | Out-String) })

# PowerShell
# https://learn.microsoft.com/en-us/powershell/scripting/learn/shell/using-aliases
Set-Alias which Get-Command
Set-Alias touch New-Item

function take{
    mkdir -f $args[0] && cd $args[0]
}

function rmrf {
    Remove-Item -Recurse -Force $args
}

function grep($pattern) {
    $input | Out-String -Stream | Select-String $pattern
}

function Unfold-Alias {
    (Get-Command $args).Definition
}

Set-Alias uf Unfold-Alias

function Unfold-Alias2 {
    (Get-Command (Get-Command $args).Definition).Definition
}
Set-Alias uf2 Unfold-Alias2

# Scoop
Set-Alias -Name scp scoop

# Editor
Set-Alias -Name e code

# Git
Set-Alias g git

function git-status {
    git status $args
}
Set-Alias gs git-status

function git-log {
    git log $args
}
Set-Alias glg git-log

function git-log-oneline {
    git log --oneline --decorate=no $args
}
Set-Alias glo git-log-oneline

function git-switch {
    git switch $args
}
Set-Alias gsw git-switch

function git-branch {
    git branch $args
}
Set-Alias gbr git-branch

function git-clean {
    git clean $args
}
Set-Alias gcl git-clean

function git-add {
    git add $args
}
Set-Alias gad git-add

function git-commit {
    git commit $args
}
Set-Alias gct git-commit

function git-add-commit {
    git add -A; git commit $args
}
Set-Alias gca git-add-commit

function git-push {
    git push $args
}
Set-Alias gph git-push

function git-pull {
    git pull $args
}
Set-Alias gpl git-pull

function git-diff {
    git diff $args
}
Set-Alias gdf git-diff
