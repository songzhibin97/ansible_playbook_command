# .bashrc

# User specific aliases and functions

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

export WORKON_HOME=~/Env
export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages'
export VIRTUALENVWRAPPER_PYTHON=/opt/python3/bin/python3 
