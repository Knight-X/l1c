#!/bin/bash

set -e

ulimit -Sv 2700000

pushd $HOME

# Poly/ML

export PATH=$PATH:$HOME/polyml/bin
export LD_LIBRARY_PATH=$HOME/polyml/lib

if which poly >/dev/null; then
    echo "Dependencies already appear to be present. Not rebuilding them."
    exit 0
fi

svn checkout --quiet svn://svn.code.sf.net/p/polyml/code/trunk polyml
pushd polyml/polyml
./configure --prefix=$HOME/polyml --enable-shared
make
make compiler
make install
popd

# HOL

git clone --quiet https://github.com/mn200/HOL.git
pushd HOL
git checkout tags/kananaskis-10
poly < tools/smart-configure.sml
bin/build -nograph
popd

popd

ls -a
