

# ...................... AUR

# Prerequisites to install AUR packages
pacman -S --needed base-devel git --noconfirm 	

# Enable "pamac AUR"
sed --in-place "s/#EnableAUR/EnableAUR/" "/etc/pamac.conf"	

# Check for AUR Updates
sed --in-place "s/#CheckAURUpdates/CheckAURUpdates/" "/etc/pamac.conf"



# Yay (Install Packages)

YAY_INSTALL=(
    nerd-fonts-complete
    espanso
    dropbox
)

for app_yay_install in ${YAY_INSTALL[@]}; do
  if ! yay -Q | grep -q $app_yay_install; then
    yay -S "$app_yay_install" --noconfirm
  else
    echo "[DONE] - $app_yay_install"
  fi
done

# Pamac (Remove Packages)

PAMAC_REMOVE=(

)

for app_pamac_remove in ${PAMAC_REMOVE[@]}; do
  if ! pamac list --installed | grep -q $app_pamac_remove; then
    pamac build "$app_pamac_remove" --no-confirm
  else
    echo "[REMOVED] - $app_pamac_remove"
  fi
done

pamac update -a --no-confirm

# Pamac (Install Packages)

PAMAC_INSTALL=(

)

for app_pamac_install in ${PAMAC_INSTALL[@]}; do
  if ! pamac list --installed | grep -q $app_pamac_install; then
    pamac build "$app_pamac_install" --no-confirm
  else
    echo "[DONE] - $app_pamac_install"
  fi
done

pamac update -a --no-confirm

# Update
pacman -Syyu --noconfirm && clear

# ========================================================
# CLI
# ========================================================

# nvm (bash)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

# Install the latest Node release and activate it.
nvm install latest

# Install the latest LTS (long-term support) Node release.
# nvm install lts


# ...................... kitty

# kitty.conf (dracula theme)
ln -s ~/.dotfiles/.config/kitty/kitty.conf ~/.config/kitty/kitty.conf


# ...................... Alacritty

# Installation
pacman -S cmake freetype2 fontconfig pkg-config make libxcb libxkbcommon python

# Completions for fish
mkdir -p $fish_complete_path[1]
cp extra/completions/alacritty.fish $fish_complete_path[1]/alacritty.fish

mkdir -p ~/.config/alacritty
ln -s ~/.dotfiles/.config/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml
ln -s ~/.dotfiles/themes/alacritty-dracula.yml ~/.config/alacritty/alacritty-dracula.yml


# ...................... fish

# Theme starship
curl -sS https://starship.rs/install.sh | sh
ln -s ~/.dotfiles/.config/starship.toml ~/.config

# Plugin manager for Fish
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher

# Fihser Plugins 
fisher install jorgebucaran/nvm.fish
fisher install jorgebucaran/autopair.fish
fisher install PatrickF1/fzf.fish
fisher install dracula/fish

# fuzzy finder
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# Set fish as the default shell
chsh -s $(which fish)

rm ~/.config/fish/config.fish
ln -s ~/.dotfiles/.config/fish/config.fish ~/.config/fish


# ...................... Neovim

# vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# pynvim
pip install pynvim

rm -r ~/.config/nvim
ln -s ~/.dotfiles/.config/nvim ~/.config


# ...................... tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
rm ~/.tmux.conf
ln -s ~/.dotfiles/.tmux.conf ~/


# ...................... mutt
mkdir -p ~/.mutt/cache/headers
mkdir ~/.mutt/cache/bodies
touch ~/.mutt/certificates

ln -s ~/.dotfiles/.mutt/muttrc ~/.mutt/muttrc
ln -s ~/.dotfiles/themes/mutt-dracula.muttrc ~/.mutt/.muttrc


# ...................... vim
rm ~/.vimrc
ln -s ~/.dotfiles/.vimrc ~/


# ...................... bash
rm ~/.bashrc
ln -s ~/.dotfiles/.bashrc ~/


# ...................... aliases
rm ~/..aliases
ln -s ~/.dotfiles/.aliases ~/


# ...................... Symbolic Links of private dotfiles

ln -s ~/Dropbox/dotfiles/espanso/personal.yml ~/Dropbox/dotfiles/espanso/utils.yml ~/.config/espanso/match
ln -s ~/Dropbox/dotfiles/newsboat/urls ~/.newsboat/urls

# Enable cronie
sudo systemctl start cronie
sudo systemctl enable cronie


crontab
* * * * * \cp ~/.local/share/okular/docdata/*.pdf.xml ~/Dropbox/dotfiles/okular; \cp -r ~/.dotfiles ~/Dropbox/dotfiles


# ...................... rofi
mkdir -p ~/.config/rofi
ln -s ~/.dotfiles/.config/rofi/config.rasi ~/.config/rofi/


# ...................... Midnight Commander
mkdir -p ~/.local/share/mc/skins
timeout 3 mc &
ln -s ~/.dotfiles/themes/dracula256.ini ~/.local/share/mc/skins
sed -i '/Midnight-Commander/a skin=dracula256' ~/.config/mc/ini
# mc > options > appearance > dracula256


# ...................... cmus
mkdir -p ~/.config/cmus
ln -s ~/.dotfiles/.config/cmus/dracula.theme ~/.config/cmus/dracula
ln -s ~/.dotfiles/.config/cmus/rc ~/.config/cmus/rc

# ...................... tldr
pip3 install tldr

# ...................... Joplin
NPM_CONFIG_PREFIX=~/.joplin-bin npm install -g joplin
sudo ln -s ~/.joplin-bin/bin/joplin /usr/bin/joplin

#Dropbox synchronisation
#:config sync.target 7
#:sync

# ========================================================
# Miscellaneous
# ========================================================

# ...................... espanso configuration

# espanso emojis
espanso install all-emojis; espanso install lorem && espanso restart

# Translate Shell
cd $(mktemp -d)
git clone https://github.com/soimort/translate-shell
cd translate-shell/ && make && make install







# Update
pacman -Syyu --noconfirm && clear







# ========================================================
# Dracula theme
# ========================================================

mkdir -p ~/.themes ~/.icons

# Grub
git clone https://github.com/dracula/grub.git /tmp/grub
cp -r /tmp/grub/dracula /usr/share/grub/themes/
sed -i 's|themes/manjaro|themes/dracula|g' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

# GTK theme
cd $(mktemp -d)
wget https://github.com/dracula/gtk/archive/master.zip
unzip master.zip -d ~/.themes
mv ~/.themes/gtk-master ~/.themes/Dracula
gsettings set org.gnome.desktop.interface gtk-theme "Dracula"
gsettings set org.gnome.desktop.wm.preferences theme "Dracula"

# Wallpaper
wget -O /usr/share/backgrounds/wallpaper.svg "https://upload.wikimedia.org/wikipedia/commons/0/0b/Mountains-1412683.svg"
gsettings set org.gnome.desktop.background picture-uri file:////usr/share/backgrounds/wallpaper.jpg

# Icons
cd $(mktemp -d)
wget https://github.com/dracula/gtk/files/5214870/Dracula.zip
unzip Dracula.zip -d ~/.icons
gsettings set org.gnome.desktop.interface icon-theme "Dracula"

# ulauncher
git clone https://github.com/dracula/ulauncher.git ~/.config/ulauncher/user-themes/dracula-ulauncher

# Terminal
cd $(mktemp -d)
git clone https://github.com/dracula/gnome-terminal
gnome-terminal/install.sh










