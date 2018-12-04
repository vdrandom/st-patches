#!/usr/bin/env zsh
ST_REPO=https://git.suckless.org/st
ST_SRC=$PWD/st
ST_CFG=$PWD/config.h
PATCHLIST=(
    st-boxdraw.patch
    st-bright-bold-text.patch
    st-disable-bold-italic-fonts.patch
    st-disable-intensity-styles.patch
)
MAKE_OPTS=(
    PREFIX=$HOME/.local
)

if [[ ! -r $ST_SRC/.git/config ]]; then
    git clone $ST_REPO $ST_SRC
    cd $ST_SRC
else
    cd $ST_SRC
    git reset --hard
    git clean -fd
    git pull
fi

cp $ST_CFG .

for patch in $PATCHLIST; do
    patch -p1 -i ../$patch
done

make $MAKE_OPTS $*
