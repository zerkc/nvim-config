_G.KM = {}
local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

vim.o.shortmess = vim.o.shortmess .. "c"
--vim.cmd("source ~/.config/nvim/lua/config/maps.vim");

local KM = {}

keymap('n', '<Space>', '', {})
vim.g.mapleader = " "

keymap("i", "<c-space>", "coc#refresh()", { noremap = true, expr= true, silent = true});

vim.cmd [[
	inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
]]



keymap("n", "gd", "<Plug>(coc-definition)", { silent = true });
keymap("n", "gy", "<Plug>(coc-type-definition)", { silent = true });
keymap("n", "gi", "<Plug>(coc-implementation)", { silent = true });
keymap("n", "gr", "<Plug>(coc-references)", { silent = true });
--keymap("n", "K", ":call <SID>show_documentation()<CR>", { silent = true });

keymap("n", "<leader>t", ":Neotree <CR>", {noremap = true, silent = true});







keymap("n", "<C-h>", "<C-w>h", { noremap = true})
keymap("n", "<C-j>", "<C-w>j", { noremap = true})
keymap("n", "<C-k>", "<C-w>k", { noremap = true})
keymap("n", "<C-l>", "<C-w>l", { noremap = true})


keymap("t", "<Esc>", "<C-\\><C-n><CR>", { noremap = true })

_G.KM = KM
