setenv all_proxy http://127.0.0.1:7890

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