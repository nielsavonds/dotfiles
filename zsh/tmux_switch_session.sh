#!/bin/zsh

SESSION_FILE=/tmp/tmux_chosen_session

rm -f $SESSION_FILE
tmux choose-session "run-shell 'echo '%%' > $SESSION_FILE'"

while [[ ! -a $SESSION_FILE ]]
do
  sleep 0.2
done

# Remove the = and : leading and trailing character
chosen_session=$(cat $SESSION_FILE)
chosen_session=$chosen_session[2,-2]

current_session=$(tmux display-message -p '#{session_name}')

tmux switch-client -t $chosen_session

# Kill the current session, but only if it is numeric and not equal to the target session
if [[ $current_session =~ "^[0-9]+$" && $current_session != $chosen_session ]]
then
  tmux kill-session -t $current_session
fi