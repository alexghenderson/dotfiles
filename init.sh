#/bin/bash

# Install Homebrew
HOMEBREW_PATH=/opt/homebrew/bin/brew
if [ ! -f $HOMEBREW_PATH ]
then
    echo "Installing homebrew"
    sudo /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo "Updating homebrew"
brew update

# Install Oh My Zsh!
OH_MY_ZSH_PATH=$HOME/.oh-my-zsh
if [ ! -d $OH_MY_ZSH_PATH ]
then
    echo "Installing Oh My Zsh"
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Root directory of dotfiles
DOTFILES_ROOT=$(cd $(dirname "$0") && pwd)



# n
N_PREFIX=$HOME/.n
if [ ! -d $N_PREFIX ]
then
    mkdir -p $N_PREFIX
fi

echo "Installing n"
brew install n

# NPM
NPMRC_PATH=$HOME/.npmrc
NPM_PREFIX=$HOME/.npm
if [ ! -f $NPMRC_PATH ]
then
    echo "Creating npmrc file"
    touch $NPMRC_PATH
    echo "prefix=$NPM_PREFIX" >> $NPMRC_PATH
fi

if [ ! -d $NPM_PREFIX ]
then
    mkdir -p $NPM_PREFIX
fi

echo "Installing node/npm lts"
n lts

# Profile Setup
PROFILE_PATH=$HOME/.profile
PROFILE_PRIVATE_PATH=$HOME/.profile-private
if [ -f $PROFILE_PATH ]
then
    echo ".profile exists; moving to $PROFILE_PATH.old"
    mv $PROFILE_PATH $PROFILE_PATH.old
fi
echo "Symlinking $PROFILE_PATH => $DOTFILES_ROOT/profile/profile"
ln -s $DOTFILES_ROOT/profile/profile $PROFILE_PATH

if [ ! -f $PROFILE_PRIVATE_PATH ]
then
    echo "Creating empty .profile-private file"
    touch $PROFILE_PRIVATE_PATH
fi

# ZSH Setup
ZPROFILE_PATH=$HOME/.zprofile
ZSHRC_PATH=$HOME/.zshrc
if [ -f $ZPROIFLE_PATH ]
then
    echo "zprofile already exists; renaming to $ZPROFILE_PATH.old"
    mv $ZPROFILE_PATH $ZPROFILE_PATH.old
fi

if [ -f $ZSHRC_PATH ]
then
    echo "zshrc already exists; renaming to $ZSHRC_PATH.old"
    mv $ZSHRC_PATH $ZSHRC_PATH.old
fi

echo "Creating symlink from $ZPROFILE_PATH => $DOTFILES_ROOT/zsh/zprofile"
ln -s $DOTFILES_ROOT/zsh/zprofile $ZPROFILE_PATH

echo "Creating symlink from $ZSHRC_PATH => $DOTFILES_ROOT/zsh/zshrc"
ln -s $DOTFILES_ROOT/zsh/zshrc $ZSHRC_PATH

# NVIM Config Setup
NVIM_FOLDER="nvim"
NVIM_PARENT="$HOME/.config" 

NVIM_PATH=$NVIM_PARENT/$NVIM_FOLDER

mkdir -p $NVIM_PARENT

if [ -d "$NVIM_PATH" -a ! -h "$NVIM_PATH" ]
then
	echo "nvim config folder exists; renaming to $NVIM_FOLDER.old"
	mv $NVIM_PATH $NVIM_PATH.old
fi

echo "Creating symlink from $DOTFILES_ROOT/nvim => $NVIM_PATH"
ln -s $DOTFILES_ROOT/nvim $NVIM_PATH

echo "Installing neovim"
brew install neovim

echo "Running neovim setup"
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
nvim --headless +PlugInstall +qa
nvim --headless +LspInstall +qa

# Starship
brew install starship

# Rust/Cargo
curl https://sh.rustup.rs -sSf | sh

