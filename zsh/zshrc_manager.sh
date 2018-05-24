time_out () { perl -e 'alarm shift; exec @ARGV' "$@"; }

# Run tmux if exists
if command -v tmux>/dev/null; then
	[ -z $TMUX ] && exec tmux
else 
	echo "tmux not installed. Run ./deploy to configure dependencies"
fi

LASTPULL=`cat ~/dotfiles/.lastpull || echo "0"`
SHOULDPULL=`date -d "-1 day" +%s`

if [ $LASTPULL -lt $SHOULDPULL ]; then
  echo "Updating configuration"
  (cd ~/dotfiles && git pull && git submodule update --init --recursive)

  date +%s > ~/dotfiles/.lastpull
fi
source ~/dotfiles/zsh/zshrc.sh
