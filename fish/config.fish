set -l os (uname)
# homebrew: https://github.com/Homebrew/brew

string match -q "Darwin" $os;
    and eval "$(/opt/homebrew/bin/brew shellenv)";
    or  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# `setenv` is to some extend equivalent to `set -gx`, check by `type setenv`

setenv XDG_CONFIG_HOME "$HOME/.config"

# address the issue that fish sets wrong colors in ssh/wsl
# see: set_color --help
setenv fish_term24bit 1

# less
setenv LESS '-sRiM -Dd+b$Du+y$ --incsearch --use-color'

fish_add_path "$HOME/.local/bin"

if type -q bat
    setenv BAT_THEME 'Catppuccin Latte'
    abbr -a b 'bat'
end

# https://github.com/catppuccin/fzf?tab=readme-ov-file#usage
setenv FZF_DEFAULT_OPTS "\
--color=bg+:#CCD0DA,bg:#EFF1F5,spinner:#DC8A78,hl:#D20F39 \
--color=fg:#4C4F69,header:#D20F39,info:#8839EF,pointer:#DC8A78 \
--color=marker:#7287FD,fg+:#4C4F69,prompt:#8839EF,hl+:#D20F39 \
--color=selected-bg:#BCC0CC \
--color=border:#9CA0B0,label:#4C4F69"

# fzf: https://github.com/junegunn/fzf
if type -q fzf
    # https://github.com/junegunn/fzf?tab=readme-ov-file#key-bindings-for-command-line
    # - preview with no decoration but number, and color
    # - <C-/> to cycle through how preview windows is displayed
    setenv FZF_CTRL_T_OPTS "
      --walker-skip .git,node_modules,target
      --preview 'bat -n --color=always {}'
      --bind 'ctrl-/:change-preview-window(down|hidden|)'"

    string match -q "Darwin" $os;
        and set -l clipboard_cmd "pbcopy";
        or  set -l clipboard_cmd "xclip -selection clipboard"
    setenv FZF_CTRL_R_OPTS "
      --with-nth 1,3.. 
      --bind 'alt-t:change-with-nth(2..|3..|1,3..)'
      --bind 'ctrl-y:execute-silent(echo -n {3..} | $clipboard_cmd)+abort'
      --color header:italic
      --header 'Press CTRL-Y to copy command into clipboard'"

    setenv FZF_ALT_C_OPTS "
      --walker-skip .git,node_modules,target
      --preview 'eza --tree --all --level=2 --color=always --icons {}'"

    fzf --fish | source
end

# nvim: https://github.com/neovim/neovim
if type -q nvim
    setenv VISUAL nvim
    setenv EDITOR nvim
end

set -g fish_greeting
set -g fish_key_bindings fish_vi_key_bindings

abbr -a tk 'take'
abbr -a rm-rf 'rm -rf'

abbr -a g git
abbr -a ga 'git add'
abbr -a gaa 'git add -A'
abbr -a gb 'git branch'
abbr -a gco 'git commit'
abbr -a gca 'git add -A && git commit -a'
abbr -a gd 'git diff'
abbr -a gdc 'git diff --cached'
abbr -a gdw 'git diff --word-diff'
abbr -a gdwc 'git diff --word-diff --cached'
abbr -a gdd 'git difftool'
abbr -a gddc 'git difftool --cached'
abbr -a gf 'git fetch'
abbr -a glo 'git log --oneline -5'
abbr -a gph 'git push'
abbr -a gpl 'git pull'
abbr -a gr 'git restore'
abbr -a gs 'git status'
abbr -a gsw 'git switch'

abbr -a e nvim
abbr -a nd 'nvim -d'

# Current date in UTC and ISO 8601 format
abbr -a now 'date -u +%Y-%m-%dT%H:%M:%SZ'

# eza: https://github.com/eza-community/eza
abbr -a l   'eza --group-directories-last'
abbr -a ls  'eza --group-directories-last'
abbr -a ll  'eza --group-directories-last --long'
abbr -a la  'eza --group-directories-last --long --all'
abbr -a lai 'eza --group-directories-last --long --all --icons'
abbr -a li  'eza --group-directories-last --icons'
abbr -a lt  'eza --group-directories-last --tree'
abbr -a lat 'eza --group-directories-last --all --tree'

# lazygit
abbr -a lg 'lazygit'
# https://github.com/jesseduffield/lazygit/blob/master/docs/Custom_Pagers.md#delta
setenv LAZYGIT_PAGER 'delta --dark --paging=never --line-numbers --hyperlinks --hyperlinks-file-link-format="lazygit-edit://{path}:{line}"'

# opencode
abbr -a oc 'opencode'

# zoxide
if type -q zoxide
    # https://github.com/ajeetdsouza/zoxide?tab=readme-ov-file#installation
    zoxide init fish | source

    # https://github.com/ajeetdsouza/zoxide?tab=readme-ov-file#environment-variables
    # options to pass to fzf; {2} in preview to skip the frecency score ({1})
    setenv _ZO_FZF_OPTS "
      --walker-skip .git,node_modules,target
      --preview 'eza --tree --all --level=2 --color=always --icons {2}'
      $FZF_DEFAULT_OPTS"
end


if status is-interactive
    # Commands to run in interactive sessions can go here
    # if type -q fastfetch
    #     fastfetch
    # end
end

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :
