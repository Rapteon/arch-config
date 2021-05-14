#!/usr/bin/env sh

hour=$(date +%H)

if [ $hour -ge 19 ]
then
	# Changing i3 config
	cp ~/.config/i3/config ~/.config/i3/dayconfig
	cp ~/.config/i3/nightconfig ~/.config/i3/config

	# Changing gtk config
	cp ~/.config/gtk-3.0/settings.ini ~/.config/gtk-3.0/day-settings.ini
	cp ~/.config/gtk-3.0/night-settings.ini ~/.config/gtk-3.0/settings.ini
else
	# Changing i3 config
	cp ~/.config/i3/config ~/.config/i3/nightconfig
	cp ~/.config/i3/dayconfig ~/.config/i3/config

	# Changing gtk config
	cp ~/.config/gtk-3.0/settings.ini ~/.config/gtk-3.0/night-settings.ini
	cp ~/.config/gtk-3.0/day-settings.ini ~/.config/gtk-3.0/settings.ini
fi

i3-msg restart > /dev/null
