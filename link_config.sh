#!usr/bin/env bash


PROGRAMS=(bat fish git nvim tmux gh)

for program in ${PROGRAMS[@]}; do
    ln -sf "$(pwd)/$program" "$HOME/.config"
    echo "Added symbolic link for $program"
done

echo "Completed"
