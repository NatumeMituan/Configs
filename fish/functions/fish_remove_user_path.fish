# Modified based on: https://github.com/fish-shell/fish-shell/issues/8604#issuecomment-3695217756
function fish_remove_user_path
    if set -l index (contains -i $argv[1] $fish_user_paths)
        set --erase --universal fish_user_paths[$index]
        echo "Updated fish_user_paths: $fish_user_paths"
    else
        echo "$argv[1] not found in fish_user_paths: $fish_user_paths"
    end
end
