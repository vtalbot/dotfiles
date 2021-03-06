#!/usr/bin/env bash
cd "$(dirname "${BASH_SOURCE}")"
git pull origin master
function doIt() {
	rsync --exclude ".git/" --exclude ".DS_Store" --exclude "bootstrap.sh" \
		--exclude "README.md" --exclude "LICENSE-MIT.txt" -av --no-perms . ~

	set cwd = "$(dirname "${BASH_SOURCE}")"
	cd ~

	if [ -d ~/.vim/bundle/nerdtree ]; then
		cd ~/.vim/bundle/nerdtree && git pull
	else
		git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree
	fi

	if [ -d ~/.vim/bundle/vim-easymotion ]; then
		cd ~/.vim/bundle/vim-easymotion && git pull
	else
		git clone https://github.com/Lokaltog/vim-easymotion.git ~/.vim/bundle/vim-easymotion
	fi

	if [ -d ~/.vim/bundle/vim-powerline ]; then
		cd ~/.vim/bundle/vim-powerline && git pull
	else
		git clone https://github.com/Lokaltog/vim-powerline.git ~/.vim/bundle/vim-powerline
	fi

	if [ -d ~/.vim/bundle/vim-hack ]; then
	    cd ~/.vim/bundle/vim-hack && git pull
	else
	    git clone https://github.com/hhvm/vim-hack.git ~/.vim/bundle/vim-hack
	fi

	cd "$cwd"

	source ~/.bash_profile
}
if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
	echo
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt
	fi
fi
unset doIt
