set os (uname)
# homebrew: https://github.com/Homebrew/brew

string match -q "Darwin" $os;
    and eval "$(/opt/homebrew/bin/brew shellenv)";
    or  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# `setenv` is to some extend equivalent to `set -gx`, check by `type setenv`

# address the issue that fish sets wrong colors in ssh/wsl
# see: set_color --help
setenv fish_term24bit 1

# less
setenv LESS '-sRiM -Dd+b$Du+y$ --incsearch --use-color'

fish_add_path "$HOME/.local/bin"

# cargo: https://github.com/rust-lang/cargo
if [ -f $HOME/.cargo/bin/cargo ]
    fish_add_path "$HOME/.cargo/bin"
end

if type -q bat
    setenv BAT_THEME 'Catppuccin Macchiato'
    abbr -a b 'bat'
end

# fzf: https://github.com/junegunn/fzf
if type -q fzf
    # https://github.com/catppuccin/fzf?tab=readme-ov-file#usage
    setenv FZF_DEFAULT_OPTS '
        --color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796
        --color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6
        --color=marker:#b7bdf8,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796
        --color=selected-bg:#494d64
        --color=border:#363a4f,label:#cad3f5'

    # https://github.com/junegunn/fzf?tab=readme-ov-file#key-bindings-for-command-line
    # - preview with no decoration but number, and color
    # - <C-/> to cycle through how preview windows is displayed
    setenv FZF_CTRL_T_OPTS "
      --walker-skip .git,node_modules,target
      --preview 'bat -n --color=always {}'
      --bind 'ctrl-/:change-preview-window(down|hidden|)'"

    string match -q "Darwin" $os;
        and set clipboard_cmd "pbcopy";
        or  set clipboard_cmd "xclip -selection clipboard"
    setenv FZF_CTRL_R_OPTS "
      --bind 'ctrl-y:execute-silent(echo -n {2..} | $clipboard_cmd)+abort'
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

fish_vi_key_bindings

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
abbr -a l   'eza'
abbr -a ls  'eza'
abbr -a ll  'eza --long'
abbr -a la  'eza --long --all'
abbr -a lai 'eza --long --all --icons'
abbr -a li  'eza --icons'
abbr -a lt  'eza --tree'
abbr -a lat 'eza --all --tree'

# lazygit
abbr -a lg 'lazygit'
# https://github.com/jesseduffield/lazygit/blob/master/docs/Custom_Pagers.md#delta
setenv LAZYGIT_PAGER 'delta --dark --paging=never --line-numbers --hyperlinks --hyperlinks-file-link-format="lazygit-edit://{path}:{line}"'

# zoxide
if type -q zoxide
    # https://github.com/ajeetdsouza/zoxide?tab=readme-ov-file#installation
    zoxide init fish | source

    # https://github.com/ajeetdsouza/zoxide?tab=readme-ov-file#environment-variables
    # options to pass to fzf, ignoring the frecency score, which is {1}
    setenv _ZO_FZF_OPTS "
      --walker-skip .git,node_modules,target
      --preview 'eza --tree --all --level=2 --color=always --icons {2}'"
end


if status is-interactive
    # Commands to run in interactive sessions can go here
end
