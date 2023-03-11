local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  -- bootstrap lazy.nvim
  -- stylua: ignore
	print(install_path)
	vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
end
vim.opt.rtp:prepend(install_path)
local g = vim.g
local api = vim.api
local cmd = api.nvim_command
local fn = vim.fn

require("config/options")
require("config/keymaps")

local function register_mappings(mappings, default_options)
	for mode, mode_mappings in pairs(mappings) do
		for _, mapping in pairs(mode_mappings) do
			local options = #mapping == 3 and table.remove(mapping) or default_options
			local prefix, cmd = unpack(mapping)
			pcall(vim.api.nvim_set_keymap, mode, prefix, cmd, options)
		end
	end
end


vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])


vim.cmd([[
highlight! link NeoTreeDirectoryIcon NvimTreeFolderIcon
highlight! link NeoTreeDirectoryName NvimTreeFolderName
highlight! link NeoTreeSymbolicLinkTarget NvimTreeSymlink
highlight! link NeoTreeRootName NvimTreeRootFolder
highlight! link NeoTreeDirectoryName NvimTreeOpenedFolderName
highlight! link NeoTreeFileNameOpened NvimTreeOpenedFile
]])

require('packer').init {
	display = {
		non_interactive = true
	},
	autoremove = true

}
require('packer').startup(function(use)
	-- is necesary for not clone always
    use { "wbthomason/packer.nvim" }
	use { "navarasu/onedark.nvim", }
    use { "mhinz/vim-signify" }
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    }
	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'kyazdani42/nvim-web-devicons', opt = true }
	}

	use { 'neoclide/coc.nvim', branch='release' }

	--use { 'sheerun/vim-polyglot' }
	use {
		"folke/trouble.nvim",
		requires = "nvim-tree/nvim-web-devicons",
		config = function()
			require("trouble").setup {
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			}
		end
	}
	use { "nvim-tree/nvim-web-devicons" }
	use {
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		requires = { 
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		}
	}

    require('packer').sync()
	--require('packer').install()
end)

require('lualine').setup()

require('onedark').setup {
    style = 'darker'
}
require('onedark').load()

g.coc_global_extensions = {
   'coc-css',
   'coc-cssmodules',
   'coc-diagnostic',
   'coc-docker',
   'coc-emmet',
   'coc-eslint',
   'coc-git',
   'coc-html',
   'coc-json',
   'coc-lua',
   'coc-phpls',
   'coc-pyright',
   'coc-react-refactor',
   'coc-sh',
   'coc-styled-components',
   'coc-svg',
   'coc-tailwindcss',
   'coc-tslint-plugin',
   'coc-tsserver',
   'coc-vetur',
   'coc-vimlsp',
   'coc-webpack',
   'coc-xml',
   'coc-yaml',
    -- 'coc-rust-analyzer'
}


require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "c", "lua", "vim", "help", "query", "javascript", "typescript", "vue", "css", "html", "php"},

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (for "all")
  --ignore_install = { "javascript" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = { "c", "rust" },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

function _G.check_back_space()
    local col = fn.col('.') - 1
    if col == 0 or fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

function _G.show_docs()
    local cw = fn.expand('<cword>')
    if fn.index({ 'vim', 'help' }, vim.bo.filetype) >= 0 then
        cmd('h ' .. cw)
    elseif api.nvim_eval('coc#rpc#ready()') then
        fn.CocActionAsync('doHover')
    else
        cmd('!' .. vim.o.keywordprg .. ' ' .. cw)
    end
end

local mappings = {
	i = { -- Insert mode
        { "<TAB>", 'pumvisible() ? "<C-N>" : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', { expr = true } },
        { "<S-TAB>", 'pumvisible() ? "<C-P>" : "<C-H>"', { expr = true } },
        { "<C-SPACE>", 'coc#refresh()', { expr = true } },
        {'<C-F>', 'coc#float#has_scroll() ? coc#float#scroll(1) : "<Right>"', { expr = true, silent = true, nowait = true }},
        {'<C-B>', 'coc#float#has_scroll() ? coc#float#scroll(0) : "<Left>"', { expr = true, silent = true, nowait = true }},
  --      {'<CR>',  'v:lua.MUtils.completion_confirm()', {expr = true, noremap = true}}
	},
	n = { -- Normal mode
        { "K", '<CMD>lua _G.show_docs()<CR>', { silent = true } },
        {'[g', '<Plug>(coc-diagnostic-prev)', { noremap = false }},
        {']g', '<Plug>(coc-diagnostic-next)', { noremap = false }},
        {'gb', '<Plug>(coc-cursors-word)', { noremap = false }},
        {'gd', '<Plug>(coc-definition)', { noremap = false }},
        {'gy', '<Plug>(coc-type-definition)', { noremap = false }},
        {'gi', '<Plug>(coc-implementation)', { noremap = false }},
        {'gr', '<Plug>(coc-references)', { noremap = false }},

        {'<C-F>', 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-F>"', { expr = true, silent = true, nowait = true }},
        {'<C-B>', 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-B>"', { expr = true, silent = true, nowait = true }},

	},
    o = {},
	t = { -- Terminal mode
	},
	v = { -- Visual/Select mode
	},
	x = { -- Visual mode
    { "<leader>a", '<CMD>lua _G.show_docs()<CR>', { silent = true } },
	},
	[""] = {
	},
}

vim.cmd([[
    " Add `:Format` command to format current buffer.
    command! -nargs=0 Format :call CocAction('format')
    " Add `:Fold` command to fold current buffer.
    command! -nargs=? Fold :call     CocAction('fold', <f-args>)
    " Add `:OR` command for organize imports of the current buffer.
    command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
]])



register_mappings(mappings, { silent = true, noremap = true })


--vim.opt.rtp:prepend(vim.env.LAZY or lazypath)
-- return { }


--if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  --vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
--end
--vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

--require("lazy").setup({
--	spec = {
		-- add LazyVim and import its plugins
--		{ "LazyVim/LazyVim", import = "lazyvim.plugins" },
		-- import any extras modules here
		-- { import = "lazyvim.plugins.extras.lang.typescript" },
		-- { import = "lazyvim.plugins.extras.lang.json" },
		-- { import = "lazyvim.plugins.extras.ui.mini-animate" },
		-- import/override with your plugins
--		{ import = "plugins" },
--	},
--	defaults = {
		-- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
		-- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
--		lazy = false,
		-- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
		-- have outdated releases, which may break your Neovim install.
--		version = false, -- always use the latest git commit
		-- version = "*", -- try installing the latest stable version for plugins that support semver
--	},
--	install = { colorscheme = { "onedark", "tokyonight", "habamax" } },
--	checker = { enabled = true }, -- automatically check for plugin updates
--	performance = {
--		rtp = {
--			-- disable some rtp plugins
--			disabled_plugins = {
--				"gzip",
--				-- "matchit",
--				-- "matchparen",
--				-- "netrwPlugin",
--				"tarPlugin",
--				"tohtml",
--				"tutor",
--				"zipPlugin",
--			},
--		},
--	},
--})
