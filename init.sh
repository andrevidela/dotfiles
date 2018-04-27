#!/bin/bash

BASEDIR=~/dotfiles/
ZSHDIR=~/.zprezto/runcoms/

mkdir ~/.vimFiles/backup
mkdir ~/.vimFiles/swapfiles
ln -s $BASEDIR/vimrc ~/.vimrc
ln -s $BASEDIR/ackrc ~/.ackrc
ln -s $ZSHDIR/zpreztorc ~/.zpreztorc
ln -s $ZSHDIR/zprofile ~/.zprofile
ln -s $ZSHDIR/zshrc ~/.zshrc
