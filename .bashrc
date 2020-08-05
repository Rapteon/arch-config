#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
#PS1='[\u@\h \W]\$ '	#Default
PS1='⟨\w⟩ Σ '
source <(kitty + complete setup bash)
