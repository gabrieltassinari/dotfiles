#!/bin/bash

VERSION=v0.0.3
LOCALDIR=$HOME/.tools
JOBS=-j$(nproc)

# Libraries
LIBEVENT_VERSION=2.1.12-stable
NCURSES_VERSION=6.4

# Programs
TMUX_VERSION=3.3
CLANGD_VERSION=16.0.2
NVIM_VERSION=v0.10.0
GO_VERSION=go1.22.5

usage() {
	cat << EOF
Usage: $(basename $0) [OPTIONS]

Arguments supported.
  -h, --help		Show helps and exit
  -v, --version		Show the version of the script
  -i, --install		Install everything
EOF
}

mkdir -p $LOCALDIR/{src,build} && cd $LOCALDIR/build

tmux() {
    wget -P $LOCALDIR/src https://github.com/libevent/libevent/releases/download/release-$LIBEVENT_VERSION/libevent-$LIBEVENT_VERSION.tar.gz
	tar -xf $LOCALDIR/src/libevent-$LIBEVENT_VERSION.tar.gz

	./libevent-$LIBEVENT_VERSION/configure \
		--prefix=$LOCALDIR \
		--disable-shared \
		--disable-openssl
	make $JOBS && make install

	wget -P $LOCALDIR/src https://ftp.gnu.org/pub/gnu/ncurses/ncurses-$NCURSES_VERSION.tar.gz
	tar -xf $LOCALDIR/src/ncurses-$NCURSES_VERSION.tar.gz

	./ncurses-$NCURSES_VERSION/configure \
		--prefix=$LOCALDIR \
		--with-pkg-config-libdir=$LOCALDIR/lib/pkgconfig
	make $JOBS && make install

	wget -P $LOCALDIR/src https://github.com/tmux/tmux/releases/download/$TMUX_VERSION/tmux-$TMUX_VERSION.tar.gz
	tar -xf $LOCALDIR/src/tmux-$TMUX_VERSION.tar.gz && cd tmux-$TMUX_VERSION

	PKG_CONFIG_PATH=$LOCALDIR/lib/pkgconfig ./configure \
		--prefix=$LOCALDIR \
		CFLAGS="-I$LOCALDIR/include -I$LOCALDIR/include/ncurses" \
		LDFLAGS="-L$LOCALDIR/lib"
	make $JOBS && make install

	cd ..
}

neovim() {
	wget https://github.com/neovim/neovim/releases/download/$NVIM_VERSION/nvim-linux64.tar.gz
	tar -xf nvim-linux64.tar.gz

	cp -R nvim-linux64/* $LOCALDIR

	git clone https://github.com/gabrieltassinari/dotfiles $LOCALDIR/dotfiles

	[[ -d $HOME/.config ]] || mkdir $HOME/.config

	files=".inputrc .tmux.conf .config/nvim .config/alacritty"
	for f in $files; do ln -sf $HOME/.tools/dotfiles/$f $HOME/$f; done
}

clangd() {
	wget https://github.com/clangd/clangd/releases/download/$CLANGD_VERSION/clangd-linux-$CLANGD_VERSION.zip
	unzip clangd-linux-$CLANGD_VERSION.zip

	cp -R clangd_$CLANGD_VERSION/* $LOCALDIR/
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
export SCRIPTS=$LOCALDIR/dotfiles/.config/scripts
export PATH=\$PATH:\$GOBIN:\$SCRIPTS:$LOCALDIR/bin
EOF

	echo "Done!"
}

case "$1" in
	-h | --help)
		usage
		;;
	-v | --version)
		echo "rootless $VERSION"
		;;
	-i | --install)
		tmux
		neovim
		clangd
		go

		cleanup
		;;
	*)
		usage
		;;
esac
