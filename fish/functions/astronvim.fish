function astronvim
    if test (count $argv) -gt 0
        set -l dir (realpath $argv[1])
        docker run -it --rm -v "$dir":/root/workspace astronvim /root/workspace
    else
        docker run -it --rm astronvim
    end
end
