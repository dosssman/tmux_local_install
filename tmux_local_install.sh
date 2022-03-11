#!/bin/bash

WORKDIR=$(pwd)

INSTALL_DIR=$1

if [ -z $INSTALL_DIR ]; then
    echo "Invalid install dir path: ""'$INSTALL_DIR'"" ; Aborting"
    exit
fi

if ! [ -f $INSTALL_DIR ]; then
    mkdir $INSTALL_DIR -p
fi

BUILD_DIR=$WORKDIR/build

if ! [ -f $BUILD_DIR ]; then
    mkdir $BUILD_DIR -p
fi

# # Installing libevent dep.
wget https://github.com/libevent/libevent/releases/download/release-2.1.12-stable/libevent-2.1.12-stable.tar.gz
tar -zxf libevent-2.1.12-stable.tar.gz -C $BUILD_DIR/.
cd $BUILD_DIR/libevent-2.1.12-stable
./configure --prefix=$INSTALL_DIR --enable-shared
make && make install

cd $WORKDIR
rm -rf libevent-2.1.12-stable.tar.gz
rm -rf $BUILD_DIR/libevent-2.1.12-stable

# # Installing ncurses dep.
wget http://ftp.vim.org/ftp/gnu/ncurses/ncurses-6.3.tar.gz
tar -zxf ncurses-6.3.tar.gz -C $BUILD_DIR/.
cd $BUILD_DIR/ncurses-6.3
./configure --prefix=$INSTALL_DIR --with-shared --with-termlib --enable-pc-files --with-pkg-config-libdir=$INSTALL_DIR/lib/pkgconfig
make && make install

cd $WORKDIR
rm -rf ncurses-6.3.tar.gz
rm -rf $BUILD_DIR/ncurses-6.3

# # Installing tmux itself
wget https://downloads.sourceforge.net/project/tmux.mirror/3.2a/tmux-3.2a.tar.gz
tar -zxf tmux-3.2a.tar.gz -C $BUILD_DIR/.
cd $BUILD_DIR/tmux-3.2a
PKG_CONFIG_PATH=$INSTALL_DIR/lib/pkgconfig ./configure --prefix=$INSTALL_DIR
make && make install

cd $WORKDIR
rm -rf tmux-3.2a.tar.gz
rm -rf $BUILD_DIR/tmux-3.2a

# # Final clean up
rm -rf $BUILD_DIR