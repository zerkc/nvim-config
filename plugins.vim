call plug#begin("~/.config/nvim/plugged")
" Plugin Section
Plug 'sheerun/vim-polyglot'

Plug 'kien/ctrlp.vim'
Plug 'maximbaz/lightline-ale'
"Plug 'josa42/nvim-lightline-lsp'
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdtree'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/vimux'

"Plug 'morhetz/gruvbox'
Plug 'olimorris/onedarkpro.nvim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

if has('nvim') || has('patch-8.0.902')
  Plug 'mhinz/vim-signify'
else
  Plug 'mhinz/vim-signify', { 'branch': 'legacy' }
endif

"git diff
Plug 'nvim-lua/plenary.nvim'
Plug 'sindrets/diffview.nvim'
Plug 'tpope/vim-fugitive'

Plug 'ryanoasis/vim-devicons'

Plug 'mg979/vim-visual-multi', {'branch': 'master'}



Plug 'nathanaelkane/vim-indent-guides'

call plug#end()
