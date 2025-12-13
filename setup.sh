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

# greetd base config
echo '
[terminal]
vt=1
[default_session]
command = "hyprland --config /etc/greetd/hyprland.conf"
user = "greeter"
' | sudo tee "/etc/greetd/config.toml" > /dev/null

#greetd hyprland config

echo '
exec-once = regreet; hyprctl dispatch exit
' | sudo tee "/etc/greetd/hyprland.conf" > /dev/null

# Setting up dotfiles and tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
rm ~/.bashrc
rm -rf ~/.config/hypr/
stow ~/dotfiles/

# Setting up default flatpaks
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install                 \
	app.zen_browser.zen         \
	com.github.tchx84.Flatseal  \
	org.gnome.Snapshot          \
	org.gnome.font-viewer       \
	org.libreoffice.LibreOffice \
	net.lutris.Lutris           \
	org.blender.Blender         \
	org.godotengine.Godot       \
	org.kde.krita               \
	org.inkscape.Inkscape       \
	org.ardour.Ardour

# Setting up AUR and AUR packages required in 
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
yay --version
cd .. && rm -rf yay
yay -S hyprdynamicmonitors-bin
