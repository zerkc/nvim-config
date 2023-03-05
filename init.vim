set number
syntax on
set relativenumber
set numberwidth=1
set clipboard=unnamedplus
set backupdir=~/.cache/vim
set showcmd
set tabstop=4
set sw=2
set ruler
set cursorline
set showmatch

so ~/.config/nvim/plugins.vim
so ~/.config/nvim/maps.vim
so ~/.config/nvim/plugin_config.vim

colorscheme onedark
"let g:gruvbox_contrast_dark = "hard"
"highlight Normal ctermbg=NONE

set laststatus=2

"source .keymaps

set noshowmode

set signcolumn=yes
