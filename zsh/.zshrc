# globbing
setopt NO_NOMATCH
setopt RM_STAR_SILENT

# completion
autoload -U compinit
compinit
_comp_options+=(GLOBDOTS)
unsetopt AUTO_MENU

# history
setopt HIST_IGNORE_SPACE
HISTFILE="$HOME/.zsh_history"
HISTSIZE=1000000000
SAVEHIST=1000000000

# job-control
setopt AUTO_CONTINUE # auto bg when disown
setopt NO_NOTIFY # wait to print child to after cmd

# prompt
setopt EMACS
WORDCHARS=@
PROMPT="%~ $ "
PROMPT2="> "

# cd
setopt AUTO_PUSHD PUSHD_IGNORE_DUPS PUSHD_MINUS

# ... fake home directories, use cd ~dw, ...
dw=$HOME/work/dw
sitemule=$HOME/work/gitlab/sitemule
coh=$HOME/work/gitlab/coh/main/services
bas=$HOME/work/gitlab/sitemule/bas/services
echo ~dw ~sitemule ~coh ~bas > /dev/null

# smart ^D
setopt IGNORE_EOF
smart-ctrl-d() {
	if [ "$BUFFER" = "" ]
	then
		if [ "$(jobs)" != "" ]
		then
			echo '' && jobs
			zle .reset-prompt
		else
			exit 0
		fi
	else
		zle .delete-char-or-list
	fi
}
zle -N smart-ctrl-d
bindkey '^D' smart-ctrl-d

# edit command-line
edit-command-line()
{
	tmp=$(mktemp)
	echo "$BUFFER" > "$tmp"
	${EDITOR:-${VISUAL:-vi}} "$tmp" < /dev/tty
	BUFFER=$(cat "$tmp")
	rm "$tmp"
	zle .accept-line
}
zle -N edit-command-line
bindkey '^X^E' edit-command-line

alias l='ls -lAh'
alias grep='grep --color=auto --exclude-dir=.git'

# Force a re-search for the executables in $PATH,
# making ^I work as expected on newly installed executables.
u() {
	PATH="$PATH"
}

d() {
	date +'Week %W, %a %F, %T'
}

screenshot()
{
	import "$@" png:- | xclip -sel clip -t image/png
	echo "Copied to clipboard"
}

# Used by AS/400 makefiles
export SYSTEM='work-build "$(LIBL)" ""'
export SYSTEM_UP='work-build "$(LIBL)" "$^"'
