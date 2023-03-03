call plug#begin("~/.config/nvim/plugged")
" Plugin Section
Plug 'sheerun/vim-polyglot'

Plug 'kien/ctrlp.vim'
Plug 'maximbaz/lightline-ale'
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdtree'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/vimux'

"Plug 'morhetz/gruvbox'
Plug 'olimorris/onedarkpro.nvim'


if has('nvim') || has('patch-8.0.902')
  Plug 'mhinz/vim-signify'
else
  Plug 'mhinz/vim-signify', { 'branch': 'legacy' }
endif

call plug#end()
