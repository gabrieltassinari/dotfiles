#!/bin/bash

VERSION=v0.0.2
LOCALDIR=$HOME/.tools
JOBS=-j$(nproc)

# Libraries
LIBEVENT_VERSION=2.1.12-stable
NCURSES_VERSION=6.4

# Programs
TMUX_VERSION=3.3
CLANGD_VERSION=16.0.2
NVIM_VERSION=v0.9.0
GO_VERSION=go1.21.0

usage() {
	cat << EOF
Usage: $(basename $0) [OPTIONS]

Arguments supported.
  -h, --help		Show helps and exit
  -v, --version		Show the version of the script
  -i, --install		Install everything
EOF
}

mkdir -p $LOCALDIR/install && cd $LOCALDIR/install

libevent() {
	wget https://github.com/libevent/libevent/releases/download/release-$LIBEVENT_VERSION/libevent-$LIBEVENT_VERSION.tar.gz
	tar -xf libevent-$LIBEVENT_VERSION.tar.gz

	./libevent-$LIBEVENT_VERSION/configure \
		--prefix=$LOCALDIR \
		--disable-shared \
		--disable-openssl
	make $JOBS && make install
}

ncurses() {
	wget https://ftp.gnu.org/pub/gnu/ncurses/ncurses-$NCURSES_VERSION.tar.gz
	tar -xf ncurses-$NCURSES_VERSION.tar.gz

	./ncurses-$NCURSES_VERSION/configure \
		--prefix=$LOCALDIR \
		--with-pkg-config-libdir=$LOCALDIR/lib/pkgconfig
	make $JOBS && make install
}

tmux() {
	wget https://github.com/tmux/tmux/releases/download/$TMUX_VERSION/tmux-$TMUX_VERSION.tar.gz
	tar -xf tmux-$TMUX_VERSION.tar.gz

	cd tmux-$TMUX_VERSION

	PKG_CONFIG_PATH=$LOCALDIR/lib/pkgconfig ./configure \
		--prefix=$LOCALDIR \
		CFLAGS="-I$LOCALDIR/include -I$LOCALDIR/include/ncurses" \
		LDFLAGS="-L$LOCALDIR/lib"
	make $JOBS && make install

	cd ..
}

clangd() {
	wget https://github.com/clangd/clangd/releases/download/$CLANGD_VERSION/clangd-linux-$CLANGD_VERSION.zip
	unzip clangd-linux-$CLANGD_VERSION.zip

	cp -R clangd_$CLANGD_VERSION/* $LOCALDIR/
}

neovim() {
	wget https://github.com/neovim/neovim/releases/download/$NVIM_VERSION/nvim-linux64.tar.gz
	tar -xf nvim-linux64.tar.gz

	cp -R nvim-linux64/* $LOCALDIR

	git clone https://github.com/gabrieltassinari/dotfiles $LOCALDIR/dotfiles

	[[ ! -d $HOME/.config ]] && mkdir $HOME/.config

	files=".inputrc .tmux.conf .vimrc .vim .config/nvim"
	for f in $files; do ln -sf $LOCALDIR/dotfiles/$f $HOME/$f; done
}

vim_plug() {
	mkdir -p ~/.vim/autoload
	wget https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim -P ~/.vim/autoload/

	$LOCALDIR/bin/nvim --headless +PlugInstall +qall 2>/dev/null
}

go() {
	wget https://go.dev/dl/$GO_VERSION.linux-amd64.tar.gz
	tar -C $LOCALDIR -xzf $GO_VERSION.linux-amd64.tar.gz
	
	rm $GO_VERSION.linux-amd64.tar.gz

	GO111MODULE=on $LOCALDIR/go/bin/go install golang.org/x/tools/gopls@latest
}

cleanup() {
	cat << EOF >> $HOME/.bashrc
# rootless.sh
alias vi='nvim'
alias vim='nvim'

export GOPATH=$LOCALDIR/go
export GOBIN=$LOCALDIR/go/bin
export PATH=\$PATH:\$GOBIN:$LOCALDIR/bin
EOF

	echo "Done!"
	rm -rf $LOCALDIR/install
}

case "$1" in
	-h | --help)
		usage
		;;
	-v | --version)
		echo "rootless $VERSION"
		;;
	-i | --install)
		echo "installing tmux"
		libevent
		ncurses
		clangd
		tmux

		echo "installing neovim"
		neovim
		vim_plug

		echo "installing go"
		go &>/dev/null

		cleanup
		;;
	*)
		usage
		;;
esac
