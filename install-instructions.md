## Installation Instructions
1. # loadkeys us
2. # setfont ter-118n
3. # iwctl
   1. device list
   2. station wlan0 get-networks
   3. station wlan0 connect <ssid>
4. # timedatectl set-ntp true
5. # cfdisk
   1. EFI System : 512M
   2. Root: 20GB
6. Filesystems
   1. # mkfs.ext4 /dev/<rootPartition>
   2. # mkfs.fat -F32 /dev/<efiPartition>
7. Mounting Partitions
   1. # mkdir /efi
   2. # mount /dev/<efiPartition> /efi
   3. # mount /dev/<rootPartition> /mnt
8. Generate Mirrorlist
   1. # reflector --latest 20 --sort rate --save /etc/pacman.d/mirrorlist
9. Install essential packages
   1. # pacstrap /mnt base linux-zen linux-firmware neovim dhcpcd man-db man-pages texinfo iwd zsh vi sudo terminus-font ntfs-3g zip unzip reflector
10. Generate Filesystem Table
   1. # genfstab -U /mnt >> /mnt/etc/fstab
   2. Append the following entries to /mnt/etc/fstab
      - tmpfs    /tmp    tmpfs    size=512M,noatime 0 0
	  - tmpfs    /var/tmp    tmpfs    size=512M,noatime 0 0
11. Chroot into Arch
   1. # arch-chroot /mnt
12. Set timezone and clock
   1. # ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
   2. # hwclock --systohc
13. Set Locale
   1. Edit the file /etc/locale.gen by uncommenting 'en_US.UTF-8 UTF-8' in it.
   2. Add the following lines to /etc/locale.conf and /etc/vconsole.conf respectively.
      - LANG=en_US.UTF-8 to /etc/locale.conf
	  - KEYMAP=us to /etc/vconsole.conf
     - `FONT=ter-i18n` to /etc/vconsole.conf 
   3. Run the commands
      `locale-gen`
      `localectl`
14. Set Hostname
   1. # echo <hostname> > /etc/hostname
   2. Append the following to /etc/hosts (without '-')
      - 127.0.0.1	localhost
	  - ::1			localhost
	  - 127.0.0.1	<hostname>.<domain>		<hostname>
15. Connect to the network by following step 3.
16. Set password for root
    1. # passwd
17. Install bootloader
    1. # pacman -S grub efibootmgr
	2. # grub-install --target=x86_64-efi /dev/<disk> --efi-directory=/boot/grub --bootloader-id=arch_grub
18. Install CPU microcode
    1. # pacman -S <[intel|amd]>-ucode
	2. # grub-mkconfig -o /boot/grub/grub.cfg
19. Exit Chroot by pressing Ctrl+D
20. Unmount all partitions
    1. # umount -R /mnt
	2. # reboot
21. Login to `root` user
22. Create a non-root user
    1. # useradd -m -s /bin/zsh <username>
    2. # passwd <username>
    3. Install sudo to enable user to execute makepkg later.
       - # pacman -S sudo
       - Edit sudoers file using. Refer my sudoers in arch-config.
         - # visudo
XX	Setup services
	systemctl enable dhcpcd.service
	systemctl start dhcpcd.service
	 # Timer for periodically to allow pacman to discard periodically
	# unused packages.
	systemctl enable paccache.timer
	systemctl start paccache.timer
23. Set journal size
    1. Add the following to /etc/systemd/journald.conf.d/00-journal-size.conf. Create file and directory if missing.
	   - [Journal]
	   - SystemMaxUse=30M
24. Install GUI
    1. # pacman -S xorg-server xf86-video-<[intel|amd]> xorg-xinit xorg-xev xorg-xinit i3-gaps i3status rofi udisks2 code xarchiver ttf-font-awesome ttf-fira-code ttf-fira-sans ttf-linux-libertine bdf-unifont unicode-character-database unicode-emoji unicode-cldr sxhkd seahorse gnome-keyring capitaine-cursors adapta-gtk-theme pavucontrol galculator
	2. Edit .xinitrc of the non-root user.
	   - $ nvim .xinitrc
      - $ cp /etc/X11/xinit/xinitrc
      - Comment the lines
         `twm &`
         xclock -geometry 50x50-1+1 &
         and so on.
	   - Append the following line
	     - exec i3
25. Install essential applications
    1. # pacman -S firefox chromium kitty pcmanfm-gtk3 vlc papirus-icon-theme lxappearance alsa-utils pulseaudio pulseaudio-alsa volumeicon network-manager-applet dunst xorg-xbacklight htop feh git xdg-user-dirs xpad lxqt-policykit
    2. Install the pling store and additional themes using the former. Search for 'pling store' online.
26. Edit /etc/systemd/resolved.conf after enabling and starting 'systemd-resolved.service'. Use resolved.conf file in arch-config repo.
27. Uncomment 'Color' flag in /etc/pacman.conf. This will enable colors in pacman output.
28. tlp configuration
    1. # pacman -S tlp
    2. Copy the tlp configuration file from arch-config repo. The file used by the system is placed in /etc
29. Enable notifications.
    1. Copy dunstrc file from .config/dunst in the arch-config repo. Also place the file org.freedesktop.Notifications.service in the location mentioned within the file.
30. Enable Redshift
    1. # pacman -S redshift python-xdg python-gobject geoclue
    2. Copy the file geoclue.conf to /etc/geoclue
31. Enable lockscreen
    1. # pacman -S xsecurelock
32. Start i3 by typing `startx` as non-root user.
33. Create default user directories by typing the following into a terminal
	`xdg-user-dirs-update`
34. Setup shortcuts by copying sxhkdrc file to .config/sxhkd/ 
	Check if i3 config contains a line to start sxhkd
	If not, add it
35. Install and setup a firewall
	sudo pacman -S firewalld
	systemctl enable firewalld.service
