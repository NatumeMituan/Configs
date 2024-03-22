function fish_user_key_bindings
  if type -p fzf > /dev/null
    fzf --fish | source
  end
  bind --erase \cr
end
