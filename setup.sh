#!/bin/bash

BREW=$(which brew)
APT=$(which apt)
GIT_NAME=$(git config --global user.name)
GIT_EMAIL=$(git config --global user.email)

# Copy .gitmessage into place if not already present
if [ ! -f ~/.gitmessage ]; then
  echo "Copying .gitmessage to ~/.gitmessage"
  cp .gitmessage ~/.gitmessage
fi

# Get user details if not already provided
read -p "Enter full name [$GIT_NAME]: " git_name
read -p "Enter email address [$GIT_EMAIL]: " git_email
git_name=${git_name:-$GIT_NAME}
git_email=${git_email:-$GIT_EMAIL}

# Update git global config
git config --global user.name "$git_name"
git config --global user.email "$git_email"
git config --global push.default current
git config --global core.editor "vi"
git config --global core.excludesfile ~/.gitignore_global
git config --global commit.template ~/.gitmessage

# Install tig
echo "Installing tig. Password may be required..."
if [ -x "$(APT)" ]; then
  sudo apt install tig
elif [ -x "$(BREW)" ]; then
  brew install tig
fi
