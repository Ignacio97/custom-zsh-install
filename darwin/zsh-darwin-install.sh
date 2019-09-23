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
if [ ! -d $(xcode-select -p) ]; then
    echo "${GREEN}Installing Command Line Tools."
    xcode-select --install
else
    echo "${RED}Already installed."
fi

#install homebrew
if [ -z "$(which brew)" ]; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

    brew update
    brew upgrade
    brew doctor
else
    echo "${RED}Brew already installed."
fi

brew install zsh

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended

