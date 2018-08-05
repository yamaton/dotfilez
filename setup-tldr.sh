#!/bin/bash

# * Usage
# Run `./setup-dldr.sh <target-dir>`
# Then it will clone tlcr-cpp-client under <target-dir> and install it.

if [ "$#" -gt 0 ]; then
    REPO_DIR="$1"
else
    REPO_DIR="$HOME"/repos
    if [ ! -d "$REPO_DIR" ]; then
        mkdir "$REPO_DIR"
    fi
fi

sudo apt install -y libzip-dev libcurl4-openssl-dev  # tldr needs them
cd "${REPO_DIR}"
if [ ! -d tldr-cpp-client ]; then
    git clone https://github.com/tldr-pages/tldr-cpp-client.git
    cd tldr-cpp-client
else
    cd tldr-cpp-client
    git pull
fi
./deps.sh
make
sudo make install
cp autocomplete/complete.zsh ~/.tldr.complete
echo "source ~/.tldr.complete" >> ~/.zshrc