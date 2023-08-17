setenv VISUAL nvim
setenv EDITOR nvim
setenv ALL_PROXY http://127.0.0.1:7890

setenv FZF_DEFAULT_COMMAND 'fd --type file --follow'
setenv FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND --search-path \$dir"
setenv FZF_ALT_C_COMMAND $FZF_CTRL_T_COMMAND

setenv FZF_DEFAULT_OPTS '
--height 80% --layout=reverse --border
--color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796
--color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6
--color=marker:#f4dbd6,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796'

fish_vi_key_bindings

abbr -a c clear
abbr -a e nvim
abbr -a g git
abbr -a gst 'git status'

# https://github.com/ogham/exa
if type -p exa > /dev/null
    abbr -a l 'exa'
	abbr -a ls 'exa'
	abbr -a ll 'exa -l'
	abbr -a la 'exa -la'
	abbr -a li 'exa --icons'
    abbr -a lt 'exa --tree'
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
