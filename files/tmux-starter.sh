#!/run/current-system/sw/bin/bash

tmux kill-session -t Pedro
tmux new-session -d -t Pedro

tmux new-window -n home
tmux send-keys -t 'home' 'cd ~' C-m 'clear' C-m

tmux new-window -n 'github_com'
tmux send-keys -t 'github_com' 'cd ~/Repositories/github.com' C-m 'clear' C-m

tmux new-window -n 'gitlab_com'
tmux send-keys -t 'gitlab_com' 'cd ~/Repositories/gitlab.com' C-m 'clear' C-m

tmux set-option -g history-limit 5000
tmux set-option -g mouse on

tmux attach-session -t Pedro
