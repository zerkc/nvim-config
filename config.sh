#!/bin/bash
#

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

nvim +'PlugInstall --sync' +qa

nvim +'CocInstall coc-tsserver coc-html coc-css coc-react-refactor coc-eslint coc-json coc-phpls  coc-pyright' +qa
