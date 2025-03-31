# zoxide
# https://github.com/ajeetdsouza/zoxide
Invoke-Expression (& { (zoxide init powershell | Out-String) })

# PowerShell
function Unfold-Alias {
    param([string]$alias)
    (Get-Command $alias).Definition
}
Set-Alias uf Unfold-Alias

function Unfold-Alias2 {
    param([string]$alias)
    (Get-Command (Get-Command $alias).Definition).Definition
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
