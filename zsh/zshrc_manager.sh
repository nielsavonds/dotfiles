
# Run tmux if exists
if command -v tmux>/dev/null; then

  # Check if we are inside TMUX
  if [ -z $TMUX ]; then

    # Start server first. This triggers continuum restore, so we get asked about the sessions correctly
    tmux start-server

    # Open a new tmux shell
    exec tmux
  fi

else 
	echo "tmux not installed. Run ./deploy to configure dependencies"
fi

# Pull latest configuration daily
LASTPULL=`cat ~/dotfiles/.lastpull || echo "0"`
SHOULDPULL=`date -d "-1 day" +%s`

if [ $LASTPULL -lt $SHOULDPULL ]; then
  echo "Updating configuration"
  (cd ~/dotfiles && git pull && git submodule update --init --recursive)

  date +%s > ~/dotfiles/.lastpull
fi
source ~/dotfiles/zsh/zshrc.sh
