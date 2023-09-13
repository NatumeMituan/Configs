function fish_user_key_bindings
  if type -p fzf > /dev/null
    fzf_key_bindings
  end
  bind --erase \cr
end
