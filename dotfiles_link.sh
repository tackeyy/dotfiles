#!/bin/sh
DOTFILES=(.vim .vimrc .dein.toml .dein_lazy.toml .tmux .tmux.conf .tmux.conf.* .zshrc .zshrc.* .zprofile .zprofile.* .agignore .zprofile .bashrc .bash_profile .git .gitconfig .tigrc .config/peco/config.json)

for file in ${DOTFILES[@]}
do
  if [ ! -L $HOME/$file ]; then
    ln -fnsv $HOME/dotfiles/$file $HOME/$file
  fi
done
