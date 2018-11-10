#!/bin/bash

BASEDIR=$(dirname $(readlink -f "$0"))
CONFDIR="${HOME}/confs"

echo ""
echo "BASEDIR: ${BASEDIR}"
echo "CONFDIR: ${CONFDIR}"
echo ""

# configurations are in ~/confs
[ ! -d "${CONFDIR}" ] &&  mkdir "${CONFDIR}"
cd "${CONFDIR}"

# update the system
sudo apt update && sudo apt full-upgrade


# zsh
echo ""
echo "--------------------------"
echo "        zsh & more"
echo "--------------------------"
sudo apt install -y zsh

if [ -d zsh-syntax-highlighting ]; then
    cd zsh-syntax-highlighting
    git pull
    cd ..
else
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
fi

if [ -d zsh-git-prompt ]; then
    cd zsh-git-prompt
    git pull
    cd ..
else
    git clone https://github.com/starcraftman/zsh-git-prompt.git
fi
[ -f ~/.zshrc ] && mv ~/.zshrc ~/.zshrc.backup
cp "${BASEDIR}"/.zshrc ~
[ -f ~/.zshenv ] && mv ~/.zshenv ~/.zshenv.backup
cp "${BASEDIR}"/.zshenv ~


# colored man with less
echo ""
echo "--------------------------"
echo "        colored man"
echo "--------------------------"
[ -f ~/.less_termcap ] && mv ~/.less_termcap ~/.less_termcap.backup
cp "${BASEDIR}"/.less_termcap ~


# tmux
echo ""
echo "--------------------------"
echo "        tmux"
echo "--------------------------"
cd "${BASEDIR}"
./_setup-tmux.sh


# emacs
echo ""
echo "--------------------------"
echo "        emacs"
echo "--------------------------"
[ ! -x "$(command -v emacs)" ] &&  sudo apt install -y emacs-nox
[ -f ~/.emacs ] && mv ~/.emacs ~/.emacs.backup
cp "${BASEDIR}"/.emacs ~


# misc software
echo ""
echo "--------------------------"
echo "        misc software"
echo "--------------------------"
APPS="cmake htop autojump wget curl gnupg2 source-highlight jq csvtool python parallel"
sudo apt install -y $(printf "$APPS")


# tldr
echo ""
echo "--------------------------"
echo "        tldr client"
echo "--------------------------"
cd "${BASEDIR}"
./_setup-tldr.sh "${CONFDIR}"


# cht.sh
echo ""
echo "--------------------------"
echo "        cht.sh"
echo "--------------------------"
cd "${BASEDIR}"
./_setup-cheatsheet.sh


# ripgrep ---better grep---
echo ""
echo "--------------------------"
echo "        ripgrep"
echo "--------------------------"
cd "${BASEDIR}"
./_setup-ripgrep.sh


# fd ---better find---
echo ""
echo "--------------------------"
echo "        fd"
echo "--------------------------"
cd "${BASEDIR}"
./_setup-fd.sh


# nnn
echo ""
echo "--------------------------"
echo "        nnn"
echo "--------------------------"
sudo apt install -y libncursesw5-dev
./_setup-nnn.sh "${CONFDIR}"


# xsv ---better csvtools ---
echo ""
echo "--------------------------"
echo "        xsv"
echo "--------------------------"
cd "${BASEDIR}"
./_setup-xsv.sh


# gotop --system monitor ---
echo ""
echo "--------------------------"
echo "        gotop"
echo "--------------------------"
cd "${BASEDIR}"
./_setup-gotop.sh
