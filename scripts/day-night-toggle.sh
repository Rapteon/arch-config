#!/usr/bin/env sh

hour=$(date +%H)

if [ $hour -ge 19 -o $hour -lt 7 ]
then
	echo "Night"
	# Changing i3 config
	cp ~/.config/i3/nightconfig ~/.config/i3/config

	# Changing gtk config
	cp ~/.config/gtk-3.0/night-settings.ini ~/.config/gtk-3.0/settings.ini

	# Changing kitty config
	cp ~/.config/kitty/night-kitty.conf ~/.config/kitty/kitty.conf
else
	echo "Day"
	# Changing i3 config
	cp ~/.config/i3/dayconfig ~/.config/i3/config

	# Changing gtk config
	cp ~/.config/gtk-3.0/day-settings.ini ~/.config/gtk-3.0/settings.ini

	# Changing kitty config
	cp ~/.config/kitty/day-kitty.conf ~/.config/kitty/kitty.conf
fi

i3-msg restart > /dev/null
