#!/run/current-system/sw/bin/bash

tmux kill-session -t GitHub
tmux new-session -d -t GitHub

tmux new-window -n 'github_com'
tmux send-keys -t 'github_com' 'cd ~/Repositories/github.com' C-m 'clear' C-m

tmux new-window -n 'adaptoid'
tmux send-keys -t 'adaptoid' 'cd ~/Repositories/github.com/pedrodotmc/adaptoid' C-m 'clear' C-m

tmux new-window -n 'fast-cluster'
tmux send-keys -t 'fast-cluster' 'cd ~/Repositories/github.com/pedrodotmc/fast-cluster' C-m 'clear' C-m

tmux new-window -n 'nix-home'
tmux send-keys -t 'nix-home' 'cd ~/Repositories/github.com/pedrodotmc/nix-home' C-m 'clear' C-m

tmux set-option -g history-limit 5000
tmux set-option -g mouse on

tmux attach-session -t GitHub
