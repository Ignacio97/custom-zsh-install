#!/bin/bash

#install CommandLineTools
#install curl
#install brew
#install zsh
#install oh my zsh
#install powerlevel10k
#install nerdfonts/hack
#install zsh autocomplete

RED=$(printf '\033[31m')
GREEN=$(printf '\033[32m')
YELLOW=$(printf '\033[33m')
BLUE=$(printf '\033[34m')
BOLD=$(printf '\033[1m')
RESET=$(printf '\033[m')

echo "
This script will install:
 ${RED}1º ZSH		
 ${YELLOW}2º Oh-myzsh
 ${BLUE}3º powerlevel9k
 ${GREEN}4º Nerd-fonts

$RED Addicional resources may be installed.
"

read -r -p "${RED}Are you sure you want to continue? [y/N]${RESET}" confirmation
if [ "$confirmation" != y ] && [ "$confirmation" != Y ]; then
    echo "Install cancelled"
    exit
fi

#install command line tools
echo -e "${GREEN}--------------CommandLineTools---------------"
xcode-select -p
if [ "$?" -ne "0" ]; then
    echo "${GREEN}Installing Command Line Tools."
    xcode-select --install
else
    echo "${RED}CLT already installed."
fi
echo -e "${RED}--------------CommandLineTools---------------\n"


echo -e "${GREEN}--------------HomeBrew---------------"
#install homebrew
if [ -z "$(which brew)" ]; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew update
    brew upgrade
    brew doctor
else
    echo "${RED}Brew already installed."
fi
echo -e "${RED}--------------HomeBrew---------------\n"

echo -e "${GREEN}--------------ZSH---------------"
brew install zsh
echo -e "${RED}--------------ZSH---------------\n"

echo -e "${GREEN}-----------OH-MY-ZSH---------------"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended
echo -e "${RED}-----------OH-MY-ZSH---------------\n"

echo -e "${GREEN}-----------Nerd-fonts---------------"
brew install font-hack-nerd-font
echo -e "${RED}-----------Nerd-fonts---------------\n"

#install zsh-syntax-highlighting
echo -e "${GREEN}-----------zsh-syntax-highlighting---------------"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
echo -e "${RED}-----------zsh-syntax-highlighting---------------\n"

#install zsh-autosuggestions
echo -e "${GREEN}-----------zsh-autosuggestions---------------"
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
echo -e "${RED}-----------zsh-autosuggestions---------------\n"

#install powerlevel9k
echo -e "${GREEN}-----------powerlevel9k---------------"
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
echo -e "${RED}-----------powerlevel9k---------------\n"


#back up previous .zshrc file as .zshrc.backup

FILE=~/.zshrc
if test -e "$FILE"; then
	cp $FILE ${FILE}.backup #backup 
	echo "${GREEN}Previous $FILE saved as ${FILE}.backup..."
fi

echo '
export ZSH="$HOME/.oh-my-zsh"
export TERM="xterm-256color"

ZSH_THEME="powerlevel9k/powerlevel9k"
POWERLEVEL9K_MODE="nerdfont-complete"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(ssh dir vcs status)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()

plugins=(git vscode)

source $ZSH/oh-my-zsh.sh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
alias ls="ls -G"
	 ' > $FILE

read -r -p "${RED}SET ZSH AS DEFAULT? [y/N]${RESET}" confirmation
if [ "$confirmation" == y ] || [ "$confirmation" == Y ]; then
	#set zsh as default shell
	sudo chsh -s $(which zsh) $USER
  	echo "${GREEN}ZSH is now the default shell."
else
	echo "${RED}ZSH is not the default shell!"
	echo "${RED} TYPE zsh to use zsh"
fi

echo \
"
Do not forget to set your console font to hack
${GREEN}All done, now restart your terminal to apply settings!
"

echo -e "\n\n${GREEN}Hasta la vista baby!"
exit