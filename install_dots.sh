#!/bin/sh


dots_dir=$(pwd)
backup_dir=$HOME/dots_backup

# Args: $1: dotfile name, $2: destination
install_dotfile() {
	# If destination is a symlink, remove it 
	if [ -L $2 ]; then
		echo "Removing symlink $2"
		rm $2
	fi

	# If destination exists, make backup and remove
	if [ -f $2 ]; then
	mkdir -p $HOME/dots_backup
	echo "Backing up $2 to $backup_dir/$2"
	cp $2 $backup_dir
	fi

	# Symlink dotfile to destination
	ln -s -v $1 $2
	echo "Installed $1 to $2"
}

# Args: $1: source_dir, $2: destination
install_dir() {
	# If destination is a symlink, remove it
	if [ -L $2 ] && [ -d $2 ]; then
		echo "Removing symlink $2"
		rm $2
	fi

	# If destination exists, make backup and remove
	if [ -d $2 ]; then
	mkdir -p $HOME/dots_backup
	echo "Backing up $2 to $backup_dir/$2"
	mv $2 $backup_dir
	fi

	# Symlink dir to destination
	ln -s -v $1 $2
	echo "Installed $1 to $2"
}

# Install dotfiles:
echo "Installing dotfiles..."

# Symlinking dotfiles:
install_dotfile $dots_dir/zshrc $HOME/.zshrc
install_dotfile $dots_dir/tmux.conf $HOME/.tmux.conf

mkdir -p $HOME/.config/nvim  # Create nvim config dir if it doesn't exist
install_dotfile $dots_dir/init.vim $HOME/.config/nvim/init.vim

# Symlinking dirs:
echo "Installing dirs..."
install_dir $dots_dir/scripts/ $HOME/Scripts

