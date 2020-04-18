#!/bin/bash
HOSTS=${HOSTS:=$*}
if [ -z "$HOSTS" ]; then
   echo -n "Please provide of list of hosts separated by spaces [ENTER]: "
   read HOSTS
fi

hosts=( ${HOSTS} )

tmux new-window "ssh ${hosts[0]}"
unset hosts[0];
for i in "${hosts[@]}"; do
  tmux split-window -v  "ssh $i"
  #tmux select-layout even-vertical
  tmux select-layout tiled
done
tmux select-pane -t 0
tmux set-window-option synchronize-panes on
