# Installation
 
$ ls /sys/firmware/efi/efivars

# Set the keyboard layout
    ls -R /usr/share/kbd/keymaps

# Partition your disk
    cfdisk /dev/sda 

# Format and mount partitions

    mkfs.fat -F 32 /dev/sda1
    fatlabel /dev/sda1 BOOT
    mkfs.ext4 -L ROOT /dev/sda2        
    mkfs.ext4 -L HOME /dev/sda3  
    mount /dev/disk/by-label/ROOT /mnt
    mkdir /mnt/boot
    mkdir /mnt/home 
    mount /dev/disk/by-label/BOOT /mnt/boot 
 
    mkswap -L SWAP /dev/sda4           
    swapon /dev/disk/by-label/SWAP 

# Connect to the Internet
    ping artixlinux.org

# Update the system clock
    rc-service ntpd start

# Install base system
    basestrap /mnt base base-devel openrc elogind-openrc

# Install a kernel
    basestrap /mnt linux linux-firmware

# Use fstabgen to generate /etc/fstab, use -U for UUIDs as source identifiers and -L for partition labels: 
    fstabgen -U /mnt >> /mnt/etc/fstab

# Check the resulting fstab for errors before rebooting. Now, you can chroot into your new Artix system with: 
 artix-chroot /mnt

# Configure the system clock
    ln -sf /usr/share/zoneinfo/Region/City /etc/localtime
    hwclock --systohc

# Localization
    pacman -Syu
    nano /etc/locale.gen
    locale-gen

To set the locale systemwide, create or edit /etc/locale.conf (which is sourced by /etc/profile) or /etc/bash/bashrc.d/artix.bashrc or /etc/bash/bashrc.d/local.bashrc; user-specific changes may be made to their respective ~/.bashrc, for example:

    export LANG="en_US.UTF-8"    
    export LC_COLLATE="C"

# Chroot into your new Artix
 artix-chroot /mnt # formerly artools-chroot

# Boot Loader

    pacman -S grub os-prober efibootmgr
    grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=grub
    grub-mkconfig -o /boot/grub/grub.cfg

# Update

	sudo pacman -Syu neovim git

# Add user(s)

    passwd
    useradd -m user
    passwd user

# Network configuration

    nvim /etc/hostname

nvim /etc/hosts
 
     127.0.0.1        localhost
     ::1              localhost
     127.0.1.1        myhostname.localdomain  myhostname

If you use OpenRC you should add your hostname to /etc/conf.d/hostname too: 

    hostname='myhostname'

# Install connman and optionally a front-end:

    pacman -S connman-openrc connman-gtk
    rc-update add connmand

# Reboot the system

    exit                           
    umount -R /mnt
    sudo reboot


# Grant root access to our user
    EDITOR=nvim visudo
 
Adding the Username to the Sudoers File

    su root
    
    root	ALL=(ALL:ALL) ALL
    USERNAME  	ALL=(ALL:ALL) ALL

# Login into newly created user
    su - USERNAME

# Add Arch Linux repos, extra + Community
	sudo pacman -Syu artix-archlinux-support
	git clone https://github.com/euberfs/artix_i3.git
	cd artix_i3 & sudo cat repos >> /etc/pacman.conf
	sudo pacman-key --populate archlinux

# Post installation configuration
	cd artix_i3 
	sudo sh apps_pacman.sh

# HOME directory
	xdg-user-dirs-update

# Dofiles
	cp -r ~/artix_i3/.dotfiles ~/
	cd artix_i3/.dotfiles && stow .

# Reboot the system

    sudo reboot

# polybar
git clone --depth=1 https://github.com/adi1090x/polybar-themes.git && cd polybar-themes
cd ~/polybar-themes && chmod +x ./setup.sh && ./setup.sh 
rm -rf $HOME/polybar-themes
 
# tmux
Tmux PlugManager
    git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm

.tmux.conf
    tmux source ~/.tmux.conf
    Press prefix + I  to fetch the plugin.

# Add asteriks when you type your password
    echo 'Defaults pwfeedback'|sudo tee /etc/sudoers.d/0pwfeedback

# yay

    git clone https://aur.archlinux.org/yay.git
    cd yay && makepkg -si && cd
    rm -r yay
    
Apps

espanso
Dropbox
timer-bin
lf-git
sc-im
simple-mtpfs
task-spooler
networkmanager-dmenu
tgpt-bin
perl-image-exiftool

# mc
Choose the skin through the mc UI with F9 > Options > Appearance

# npm
    sudo npm install -g wikit tldr nativefier

# Update
    sudo pacman -Syyu --noconfirm && clear

# Fix "unable to lock database" Error in Arch Linux
    sudo rm /var/lib/pacman/db.lck

# Enable "pamac AUR"
    sudo sed --in-place "s/#EnableAUR/EnableAUR/" "/etc/pamac.conf"

# Check for AUR Updates
    sudo sed --in-place "s/#CheckAURUpdates/CheckAURUpdates/" "/etc/pamac.conf"

# Enabling parallel compiling to improve the compiling speed
sed -i 's/#MAKEFLAGS="-j2"/MAKEFLAGS="-j$(nproc)"/g' /etc/makepkg.conf	

# Weekly updates
No tray icon if there are no updates

    sudo sed -Ei '/NoUpdateHideIcon/s/^#//' /etc/pamac.conf

# Download in background
    sudo sed -Ei '/DownloadUpdates/s/^#//' /etc/pamac.conf

# Disable GRUB delay
    sudo sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=0/' /etc/default/grub
    sudo update-grub

# Install display manager
    sudo rc-service lightdm start
    sudo nvim /etc/lightdm/lightdm-gtk-greeter.conf

# In this file you have to add these lines
       [greeter]
       theme-name = Arc-Dark
       icon-theme-name = Papirus-Dark
       background = #2f343f
# Paru
sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si

# geany
Activating theme
    Copy the Dracula-Theme.conf into ~/.config/geany/colorschemes/. Create it if the directory doesn't exist.
    Choose the theme on Geany by going to the view menu and selecting Change Color Scheme..
    
# nvm
    wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash

# File previewer for a terminal
git clone https://github.com/NikitaIvanovV/ctpv
cd ctpv
make
sudo make install

# fish

Set fish as the default shell
    chsh -s $(which fish)

Theme
    fish_config

Plugin manager for Fish
    curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher

Fisher Plugins
    fisher install jorgebucaran/nvm.fish
    fisher install jorgebucaran/autopair.fish
    fisher install PatrickF1/fzf.fish
    fisher install edc/bass
    fisher install decors/fish-colored-man
    fisher install budimanjojo/tmux.fish

Oh My Fish
    curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish

OMF Plugins
    omf install bobthefish
    
# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.config/fzf && ~/.config/fzf/install

FZF dracula theme (On Fish, run the following one time):
    set -Ux FZF_DEFAULT_OPTS "--color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4"

# Neovim
    sudo npm -g install instant-markdown-d

# Joplin CLI
    NPM_CONFIG_PREFIX=~/.config/joplin npm install -g joplin && sudo ln -s ~/.config/joplin/bin/joplin /usr/bin/joplin

Dropbox synchronisation

    :config sync.target 7
    :sync
    :config editor nvim

# mutt
    mkdir -p ~/.config/mutt/cache/{headers,bodies} && touch ~/.config/mutt/certificates
    cp ~/.dotfiles/mutt/muttrc ~/.config/mutt/ 

# Sync PDFs Okular
    cp ~/Dropbox/dotfiles/okular/* ~/.local/share/okular/docdata

# crontab
    * * * * * \cp ~/.local/share/okular/docdata/*.pdf.xml ~/Dropbox/dotfiles/okular; \cp -r ~/.dotfiles ~/Dropbox/dotfiles

# Remove orphans
    sudo pacman -Rns $(pacman -Qtdq) --noconfirm

# Update
    sudo pacman -Syyu --noconfirm && clear

# Firefox
    https://addons.mozilla.org/es/firefox/addon/gruvbox-dark-theme/
    https://addons.mozilla.org/es/firefox/addon/nord-firefox/
    https://addons.mozilla.org/en-US/firefox/addon/dracula-dark-colorscheme/
    
    https://addons.mozilla.org/en-US/firefox/addon/ublock-origin/
    https://addons.mozilla.org/en-US/firefox/addon/decentraleyes/
    https://addons.mozilla.org/en-US/firefox/addon/istilldontcareaboutcookies/
    https://addons.mozilla.org/en-US/firefox/addon/styl-us/

# If " externally-managed-environment error"
sudo rm /usr/lib/pythonXXX/EXTERNALLY-MANAGED

# Sound problems mulitpile card
    sudo vim  /etc/modprobe.d/alsa-base.conf

# Add this content int o alsa-base.conf (swaps sound cards, so 1 is default)
options snd-hda-intel index=1,0l

# Enable audio
    sudo nvim /etc/asound.conf

    defaults.pcm.card 1
    defaults.pcm.device 0
    defaults.ctl.card 1

amixer sset Master unmute

# Libreoffice
cd $(mktemp -d)
wget https://github.com/dracula/libreoffice/archive/master.zip
unzip master.zip
timeout 3 libreoffice &
cp libreoffice-master/dracula.soc ~/.config/libreoffice/*/user/config/

# Update fonts
fc-cache -f -v

# Remove orphans
pacman -Rns $(pacman -Qtdq) --noconfirm

# Timeshift snapshot
timeshift --create --comments "First Backup" --tags D

# Update
pacman -Syyu --noconfirm && clear

# Theme and icons (gruvbox)
mkdir -p $HOME/.local/share/{themes,icons} && cd && git clone https://github.com/TheGreatMcPain/gruvbox-material-gtk.git 
cp -r $HOME/gruvbox-material-gtk/themes/* $HOME/.local/share/themes/ ; cp -r $HOME/gruvbox-material-gtk/icons/* $HOME/.local/share/icons/ 
rm -rf $HOME/gruvbox-material-gtk    

--------------------
# zsh
    chsh -s $(which zsh)

Oh My Zsh!

    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    export HISTFILE=~/.config/zsh/.zsh_history
    export HISTSIZE=1000
    export SAVEHIST=1000

    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.config/zsh/oh-my-zsh/custom}/themes/powerlevel10k
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting


 
