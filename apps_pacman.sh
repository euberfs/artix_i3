#!/usr/bin/env bash
# Pacman (Remove Packages)

PACMAN_REMOVE=(
)

for app_pacman_remove in ${PACMAN_REMOVE[@]}; do
  if pacman -Q | grep -q $app_pacman_remove; then
    pacman -R "$app_pacman_remove" --noconfirm
  else
    echo "[REMOVED] - $app_pacman_remove"
  fi
done

# Pacman (Install Packages)

PACMAN_INSTALL=(
xorg-server
xorg-apps
xorg-xinit
xorg-xinput
i3
i3lock
rofi
trahs-cli
python-pywal
alsa-firmware
iw
wpa_supplicant
gping
dialog
intel-ucode
pulseaudio
pavucontrol
bluez
bluez-utils
blueman
tlp
tlp-rdw
powertop
geany
github-cli
acpi
dhcpcd
networkmanager
network-manager-applet
reflector
kitty
stow
curl
git
wget
npm
scrot
mutt
calc
tmux
zenity
ueberzug
dmenu
feh
cmus
zathura
zathura-pdf-mupdf
fastfetch
thunar
firefox
ffmpegthumbnailer
picom
gnome-epub-thumbnailer 
odt2txt 
newsboat
man-db
lynx
bat
networkmanager-openrc
dunst
bash-completion
neovim
tree
mpv
python-pip
exa
htop
unzip
khal
wine
wine-mono
wine-gecko
translate-shell
yad
sysstat
nitrogen
menumaker
mediainfo
atool
xorg-xinit
xdotool 
xclip 
xcape 
unclutter  
numlockx
alacritty
lightdm-openrc
lightdm-gtk-greeter
ttc-iosevka
noto-fonts
ttf-font-awesome
ttf-ubuntu-font-family
ttf-dejavu
ttf-freefont
ttf-liberation
ttf-droid
ttf-roboto
terminus-font
xdg-user-dirs
nodejs
python-gpgme
cron
cronie
timeshift
lsd
duf
procs
zip
ufw
ffmpeg
okular
wmctrl
copyq
mc
rsync
vim
qbittorrent
libreoffice-still
ripgrep
fd
timeshift
)

for app_pacman_install in ${PACMAN_INSTALL[@]}; do
  if ! pacman -Q | grep -q $app_pacman_install; then
    pacman -S "$app_pacman_install" --noconfirm
  else
    echo "[DONE] - $app_pacman_install"
  fi
done
