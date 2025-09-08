#!/usr/bin/env bash

sudo pacman -Syu
sudo pacman -Sy \
	ghostty \
	zsh \
	stow \
	tmux \
	neovim \
	fzf \
	ripgrep \
	flatpak \
	hyprlock \
	hypridle \
	hyprpaper \
	rofi \
	waybar \
	grim \
	slurp \
	bluez \
	bluetui

stow ~/dotfiles/
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install \
	app.zen_browser.zen \
	com.github.tchx84.Flatseal \
	org.gnome.Snapshot \
	org.gnome.font-viewer \
	org.libreoffice.LibreOffice \
	net.lutris.Lutris \
	org.blender.Blender \
	org.godotengine.Godot \
	org.kde.krita \
	org.inkscape.Inkscape \
	org.ardour.Ardour

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
yay --version
cd .. && rm -rf yay
