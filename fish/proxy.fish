# Run one time: `source fish/proxy.fish`
# The universial variable will be stored
# in fish/fish_variables and will be 
# persisted across restarts of the shell.
# See: `set --help` in fish

set -Ux ALL_PROXY http://127.0.0.1:7890/
set -Ux all_proxy socks://127.0.0.1:7890/
set -Ux HTTP_PROXY http://127.0.0.1:7890/
set -Ux http_proxy http://127.0.0.1:7890/
set -Ux HTTPS_PROXY http://127.0.0.1:7890/
set -Ux https_proxy http://127.0.0.1:7890/
set -Ux no_proxy localhost,127.0.0.0/8,::1
set -Ux NO_PROXY localhost,127.0.0.0/8,::1
