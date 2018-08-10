#!/bin/bash


BASEDIR=~/dotfiles
ZSHDIR=~/.zprezto/runcoms
 
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

mkdir -p ~/.vimFiles/backup
mkdir -p ~/.vimFiles/swapfiles
mv -f ~/.vimrc ~/.vimrc.backup
mv -f ~/.ackrc ~/.ackrc.backup
ln -s $BASEDIR/vimrc ~/.vimrc
ln -s $BASEDIR/ackrc ~/.ackrc
rm -rf ~/.zpreztorc
rm -rf ~/.zprofile
rm -rf ~/.zshrc
ln -s $BASEDIR/zpreztorc ~/.zpreztorc
ln -s $BASEDIR/zprofile ~/.zprofile
ln -s $BASEDIR/zshrc ~/.zshrc
