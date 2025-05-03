function fish_user_key_bindings
    bind -M insert  \cg 'commandline -f clear-commandline; commandline -i lazygit; commandline -f execute'
    bind -M default \cg 'commandline -f clear-commandline; commandline -i lazygit; commandline -f execute'
    bind --erase \cr
end
