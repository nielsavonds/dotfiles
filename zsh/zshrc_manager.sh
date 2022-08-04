
# Run tmux if exists
if command -v tmux>/dev/null; then

  # Check if we are inside TMUX or vscode
  if [ -z $TMUX ] && ! pstree -s $$ | grep -wq code; then

    # Start server first. This triggers continuum restore, so we get asked about the sessions correctly
    tmux start-server

    # Open a new tmux shell
    exec tmux
  fi

else 
	echo "tmux not installed. Run ./deploy to configure dependencies"
fi

source ~/dotfiles/zsh/zshrc.sh
