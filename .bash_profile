#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# This is the folder containing scripts which I use.
if [[ -d "./scripts" ]]
then
	PATH=$PATH:/home/$USER/scripts/:
fi
