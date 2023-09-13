# enable true-color to fix the issue that
# tide shows wrong colors when ssh / in wsl

# to check: python3 -m rich
setenv COLORTERM truecolor
# see: set_color --help
setenv fish_term24bit 1

# less
setenv LESS '-sRiM -Dd+b$Du+y$ --incsearch --use-color'

# homebrew: https://github.com/Homebrew/brew
if [ -f /opt/homebrew/bin/brew ]
    setenv HOMEBREW_PREFIX "/opt/homebrew";
    setenv HOMEBREW_CELLAR "/opt/homebrew/Cellar";
    setenv HOMEBREW_REPOSITORY "/opt/homebrew";
    fish_add_path "/opt/homebrew/bin" "/opt/homebrew/sbin"
    set -q MANPATH; or set MANPATH ''; set -gx MANPATH "/opt/homebrew/share/man" $MANPATH;
    set -q INFOPATH; or set INFOPATH ''; set -gx INFOPATH "/opt/homebrew/share/info" $INFOPATH;
end

# cargo: https://github.com/rust-lang/cargo
if [ -f $HOME/.cargo/bin/cargo ]
    fish_add_path "$HOME/.cargo/bin"
end

# fzf: https://github.com/junegunn/fzf
if type -p fzf > /dev/null
    setenv FZF_DEFAULT_COMMAND 'fd --follow'
    setenv FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND --search-path \$dir"
    setenv FZF_ALT_C_COMMAND $FZF_CTRL_T_COMMAND

    #catppuccin: https://github.com/catppuccin/fzf
    setenv FZF_DEFAULT_OPTS '
    --height 80% --layout=reverse --border
    --color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796
    --color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6
    --color=marker:#f4dbd6,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796'
end

# nvim: https://github.com/neovim/neovim
if type -p nvim > /dev/null
    setenv VISUAL nvim
    setenv EDITOR nvim
end

fish_vi_key_bindings

abbr -a g git
abbr -a ga 'git add'
abbr -a gc 'git commit'
abbr -a gca 'git add -A && git commit -a'
abbr -a gd 'git diff'
abbr -a gdc 'git diff --cached'
abbr -a gdw 'git diff --word-diff'
abbr -a gdwc 'git diff --word-diff --cached'
abbr -a gdd 'git difftool'
abbr -a gddc 'git difftool --cached'
abbr -a glo 'git log --oneline --decorate'
abbr -a gp 'git push'
abbr -a gr 'git restore'
abbr -a gs 'git status'

abbr -a e nvim
abbr -a nd 'nvim -d'

# Current date in UTC and ISO 8601 format
abbr -a now 'date -u +%Y-%m-%dT%H:%M:%SZ'

# eza: https://github.com/eza-community/eza
if type -p eza > /dev/null
    abbr -a l 'eza'
    abbr -a ls 'eza'
    abbr -a ll 'eza -l'
    abbr -a la 'eza -la'
    abbr -a li 'eza --icons'
    abbr -a lt 'eza --tree'
else
    abbr -a l 'ls'
    abbr -a ll 'ls -l'
    abbr -a la 'ls -la'
end


# https://github.com/wting/autojump
[ -f /opt/homebrew/share/autojump/autojump.fish ]; and source /opt/homebrew/share/autojump/autojump.fish

if status is-interactive
    # Commands to run in interactive sessions can go here
end
