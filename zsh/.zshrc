setopt NO_NOMATCH
setopt RM_STAR_SILENT

# cd
setopt AUTO_PUSHD PUSHD_IGNORE_DUPS PUSHDMINUS
CDPATH="$HOME/work/gitlab:$HOME/work/github"

# Fake home directories, use cd ~dw, ...
dw=$HOME/work/dw
coh=$HOME/work/gitlab/coh/main/services
bas=$HOME/work/gitlab/sitemule/bas/services
echo ~coh ~bas ~dw > /dev/null

# history
setopt HIST_IGNORE_SPACE
HISTSIZE=1000000000
HISTFILESIZE=1000000000
SAVEHIST=1000000000
HISTFILE="$HOME/.zsh_history"

# job-control
setopt AUTO_CONTINUE # auto bg when disown
setopt NO_NOTIFY # wait to print child to after cmd

# prompt
setopt emacs
WORDCHARS=@
PROMPT="%~ $ "
PROMPT2="> "

# completion
autoload -U compinit
compinit
unsetopt AUTO_MENU

# mappings
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line

autoload -U up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^P' up-line-or-beginning-search
bindkey '^N' down-line-or-beginning-search

alias l='ls -lAh'
alias grep="grep --color=auto --exclude-dir=.git"
alias ed='rlwrap -S: ed'

precmd() {
	if ! test "$silent_precmd_info"
	then
		# Directory Notes
		if test -f .NOTES
		then
			cat .NOTES
		fi
	fi
}

# Silence mail info
s() {
	if test "$silent_precmd_info"
	then
		unset silent_precmd_info
	else
		silent_precmd_info=Y
	fi
}

u() {
	PATH="$PATH"
}

dc() {
	if test "$#" -eq 0
	then
		echo "running dc with 10 as precision:"
		echo "$ rlwrap dc -e10k /dev/stdin"
		command rlwrap dc -e10k /dev/stdin
	else
		command dc "$@"
	fi
}

d() {
	date +'Week %W, %a %F, %T'
}

screenshot()
{
	import "$@" png:- | xclip -sel clip -t image/png
}

# Used by AS/400 makefiles
export SYSTEM='work-build "$(LIBL)" ""'
export SYSTEM_UP='work-build "$(LIBL)" "$^"'

PATH="/Users/and/perl5/bin${PATH:+:${PATH}}"; export PATH;
PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"; export PATH;
PERL5LIB="/Users/and/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/Users/and/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/Users/and/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/and/perl5"; export PERL_MM_OPT;

export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="$PATH:/usr/local/opt/inetutils/libexec/gnubin"
