# Vars
	HISTFILE=~/.zsh_history
	SAVEHIST=1000 
	setopt inc_append_history # To save every command before it is executed 
	setopt share_history # setopt inc_append_history

# Aliases
	alias v="vim -p"
	mkdir -p /tmp/log
	
	# This is currently causing problems (fails when you run it anywhere that isn't a git project's root directory)
	# alias vs="v `git status --porcelain | sed -ne 's/^ M //p'`"

# Settings
	export VISUAL=vim

mkdir -p ~/.zsh_cache
ZSH_CACHE_DIR=~/.zsh_cache

source ~/dotfiles/zsh/plugins/fixls.zsh

source ~/dotfiles/zsh/plugins/oh-my-zsh/lib/history.zsh
source ~/dotfiles/zsh/plugins/oh-my-zsh/lib/key-bindings.zsh
source ~/dotfiles/zsh/plugins/oh-my-zsh/lib/completion.zsh
source ~/dotfiles/zsh/plugins/oh-my-zsh/lib/history.zsh
source ~/dotfiles/zsh/plugins/oh-my-zsh/plugins/kubectl/kubectl.plugin.zsh
source ~/dotfiles/zsh/plugins/oh-my-zsh/plugins/helm/helm.plugin.zsh
source ~/dotfiles/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/dotfiles/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/dotfiles/zsh/keybindings.sh

# Fix for arrow-key searching
# start typing + [Up-Arrow] - fuzzy find history forward
if [[ "${terminfo[kcuu1]}" != "" ]]; then
	autoload -U up-line-or-beginning-search
	zle -N up-line-or-beginning-search
	bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
fi
# start typing + [Down-Arrow] - fuzzy find history backward
if [[ "${terminfo[kcud1]}" != "" ]]; then
	autoload -U down-line-or-beginning-search
	zle -N down-line-or-beginning-search
	bindkey "${terminfo[kcud1]}" down-line-or-beginning-search
fi

# Don't share history between terminals
unsetopt share_history

# Don't ignore expressions that have no match. This is annoying when dealing with e.g. remote files
setopt +o nomatch

# Don't cycle through all tab-complete options. Instead just show the list
setopt noautomenu
setopt nomenucomplete

source ~/dotfiles/zsh/aliases.sh
source ~/dotfiles/zsh/prompt.sh

# Enable 'command not found, install package' style completion
source /etc/zsh_command_not_found

# Allow us to reload .zshrc in all terminals by running reload_zshrc
trap "source ~/.zshrc && rehash" USR1
alias reload_zshrc="killall -u $(whoami) -s USR1 zsh && echo 'zshrc sourced' && sleep 1"