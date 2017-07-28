# .bash_profile

# User specific aliases
alias vi='mvim -v'
alias vim='mvim -v'
alias ll='ls -alh'

# User specific definitions
export EDITOR="vim"

# Source global definitions
if [ -f /etc/bashrc ];
then
	. /etc/bashrc
fi

