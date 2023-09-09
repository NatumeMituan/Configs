#!usr/bin/env bash


PROGRAMS=(bat fish git nvim tmux gh)

for program in ${PROGRAMS[@]}; do
    ln -sf "$(pwd)/$program" "$HOME/.config"
    echo "Added symbolic link for $program"
done

DOTFILES=(.clang-format)
for dotfile in ${DOTFILES[@]}; do
    ln -sf "$(pwd)/$dotfile" "$HOME"
    echo "Added symbolic link for $dotfile"
done
echo "Completed"
