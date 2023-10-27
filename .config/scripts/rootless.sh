#!/bin/bash

LOCALDIR=$HOME/.tools
JOBS=-j4
# Libraries
LIBEVENT_VERSION=2.1.12-stable
NCURSES_VERSION=6.4
# Programs
TMUX_VERSION=3.3
CLANGD_VERSION=16.0.2
NEOVIM_VERSION=v0.9.0
GO_VERSION=go1.21.0
USAGE="usage: $(basename $0) [-h|-v]

	-h, --help		Show helps and exit
	-v, --version		Show the version of the script
	-i, --install		Install everything
	    --vim		Install only vim
	    --tmux		Install only tmux"

mkdir -p $LOCALDIR/install && cd $LOCALDIR/install

libevent() {
	wget https://github.com/libevent/libevent/releases/download/release-$LIBEVENT_VERSION/libevent-$LIBEVENT_VERSION.tar.gz
	tar -xf libevent-$LIBEVENT_VERSION.tar.gz

	cd libevent-$LIBEVENT_VERSION

	./configure \
		--prefix=$LOCALDIR \
		--disable-shared \
		--disable-openssl
	make $JOBS && make install

	cd ..
}

ncurses() {
	wget https://ftp.gnu.org/pub/gnu/ncurses/ncurses-$NCURSES_VERSION.tar.gz
	tar -xf ncurses-$NCURSES_VERSION.tar.gz

	cd ncurses-$NCURSES_VERSION

	./configure \
		--prefix=$LOCALDIR \
		--with-pkg-config-libdir=$LOCALDIR/lib/pkgconfig
	make $JOBS && make install

	cd ..
}

tmux() {
	wget https://github.com/tmux/tmux/releases/download/$TMUX_VERSION/tmux-$TMUX_VERSION.tar.gz
	tar -xf tmux-$TMUX_VERSION.tar.gz

	cd tmux-$TMUX_VERSION

	PKG_CONFIG_PATH=$LOCALDIR/lib/pkgconfig ./configure \
		--prefix=$LOCALDIR \
		CFLAGS="-I$LOCALDIR/include -I$LOCALDIR/include/ncurses" \
		LDFLAGS="-L$LOCALDIR/lib -L$LOCALDIR/lib/ncurses"
	make $JOBS && make install

	cd ..
}

clangd() {
	wget https://github.com/clangd/clangd/releases/download/$CLANGD_VERSION/clangd-linux-$CLANGD_VERSION.zip
	unzip clangd-linux-$CLANGD_VERSION.zip

	cd clangd_$CLANGD_VERSION
	cp -R * $LOCALDIR/

	cd ..
}

neovim() {
	wget https://github.com/neovim/neovim/releases/download/$NEOVIM_VERSION/nvim-linux64.tar.gz
	tar -xf nvim-linux64.tar.gz

	cd nvim-linux64
	cp -R * $LOCALDIR

	# vimrc into nvim
	mkdir -p $HOME/.config/nvim
	echo "set runtimepath^=~/.vim runtimepath+=~/.vim/after
	let &packpath=&runtimepath
	source ~/.vimrc" >> $HOME/.config/nvim/init.vim

	# vim-plug + coc.nvim + dotfiles
	mkdir -p ~/.vim/autoload
	wget https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim -P ~/.vim/autoload/ && \
	    git clone https://github.com/gabrieltassinari/dotfiles.git ~/dotfiles && \
	    wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -O ~/.git-prompt.sh && \
	    cd ~/dotfiles && rm .bash_profile .bashrc .xinitrc && ./setup.sh && \
	    cp ~/.vim/coc-settings.json ~/.config/nvim/

	$LOCALDIR/bin/nvim --headless +PlugInstall +qall 2>/dev/null

	cd ..
}

go() {
	wget https://go.dev/dl/$GO_VERSION.linux-amd64.tar.gz
	tar -C $LOCALDIR -xzf $GO_VERSION.linux-amd64.tar.gz
	
	rm $GO_VERSION.linux-amd64.tar.gz

	GO111MODULE=on $LOCALDIR/go/bin/go install golang.org/x/tools/gopls@latest
}

cleanup() {
	cat << EOF >> $HOME/.bashrc
alias vi='nvim'
alias vim='nvim'

export GOPATH=$LOCALDIR/go
export GOBIN=$LOCALDIR/go/bin
export PATH=$LOCALDIR/bin:\$GOBIN:$PATH
EOF

echo "Done!"
rm -rf $LOCALDIR/install
}

case "$1" in
	-h | --help)
		echo "$USAGE"
		exit 0
		;;
	-v | --version)
		echo "rootless v0.0.1"
		exit 0
		;;
	--tmux)
		echo "Installing tmux"
		libevent &>/dev/null 
		ncurses &>/dev/null
	       	tmux &>/dev/null

		cleanup
		;;
	--vim)
		echo "Installing neovim"
	       	ncurses &>/dev/null
	       	clangd &>/dev/null
	       	neovim &>/dev/null
		cleanup
		;;
	-i | --install)
		echo "Installing tmux"
		libevent &>/dev/null 
		ncurses &>/dev/null
	       	tmux &>/dev/null

		echo "Installing neovim"
	       	ncurses &>/dev/null
	       	clangd &>/dev/null
	       	neovim &>/dev/null

		echo "Installing go"
		go &>/dev/null
		cleanup
		;;
	*)
		echo "$USAGE"
		exit 0
		;;
esac
