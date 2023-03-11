#!/bin/bash


TMPDIR=$(mktemp -d)

git clone https://github.com/zerkc/nvim-config $TMPDIR

mkdir -p ~/.config/nvim/

mv $TMPDIR/* ~/.config/nvim/
mv $TMPDIR/.* ~/.config/nvim/

rm -rf $TMPDIR 

#cd ~/.config/nvim/ && ./config.sh

echo "Successfully Install"
