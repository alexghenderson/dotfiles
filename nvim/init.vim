let mapleader = " "

call plug#begin()

Plug 'github/copilot.vim'
Plug 'nvim-lua/plenary.nvim'
Plug 'BurntSushi/ripgrep'
Plug 'nvim-telescope/telescope-fzf-native.nvim'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-telescope/telescope.nvim' 
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'ThePrimeagen/harpoon'
Plug 'folke/tokyonight.nvim'

call plug#end()

colorscheme tokyonight
