#!/usr/bin/env bash

#Minimum requirements packages
sudo pacman -Syu
sudo pacman -Sy     \
	base-devel      \
	flatpak         \
	ghostty         \
	zsh             \
	stow            \
	tmux            \
	neovim          \
	fzf             \
	ripgrep         \
	hyprlock        \
	hypridle        \
	hyprpaper       \
	rofi            \
	waybar          \
	grim            \
	slurp           \
	bluez           \
	bluetui         \
	ntfs-3g         \
	cups            \
	sane            \
	ghostscript     \
	gutenprint      \
	ufw             \
	networkmanager  \
	cosmic-greeter  \
	cosmic-files    \
	cosmic-settings \
	pavucontrol

#Firewall config
sudo systemctl enable ufw.service
sudo systemctl start  ufw.service

sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
sudo ufw allow http
sudo ufw allow https
sudo ufw allow 9100 # Printer service

sudo systemctl enable NetworkManager.service
sudo systemctl start  NetworkManager.service

#Printer server
sudo systemctl enable cups.service
sudo systemctl start  cups.service

# Replacing SDDM with regreet
sudo pacman -Ry sddm

sudo systemctl enable cosmic-greeter.service
sudo systemctl start  cosmic-greeter.service

# Setting up dotfiles and tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
rm ~/.bashrc
rm -rf ~/.config/hypr/
stow ~/dotfiles/
chsh -s /usr/bin/zsh

# Setting up default flatpaks
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install             \
com.github.tchx84.Flatseal  \
org.gnome.SimpleScan        \
org.gnome.Snapshot          \
org.gnome.font-viewer       \
app.zen_browser.zen         \
org.libreoffice.LibreOffice \
com.valvesoftware.Steam     \
net.lutris.Lutris           \
org.blender.Blender         \
org.inkscape.Inkscape       \
org.kde.krita               \
org.ardour.Ardour           \
org.godotengine.Godot       \

# Setting up AUR and AUR packages required in 
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
yay --version
cd .. && rm -rf yay

# AUR PAckages
yay -S hyprdynamicmonitors-bin
