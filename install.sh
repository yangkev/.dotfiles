#!/bin/bash

###################### install.sh ############################
#
# 1. Places old dotfiles in ~/old_dotfiles
# 2. Establishes symlinks from ~/.dotfiles to ~/
#
##############################################################

############## Variables

dir=~/.dotfiles				# new dotfiles
olddir=~/.dotfiles_old		# old dotfiles backup
files=".vimrc .gitconfig .gdbinit"

# Create dotfiles_old directory
echo "Creating $olddir for backup of dotfiles in ~ that will be overwritten"
mkdir -p $olddir
echo "...done"

# Change to .dotfiles directory
cd $dir

# Move existing dotfiles to olddir, and create symlinks
for file in $files
do
	mv ~/$file $olddir
	ln -s $dir/$file ~/$file
done

# source ~/.bashrc
