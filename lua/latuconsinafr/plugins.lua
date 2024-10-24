-- Ensure packer is loaded
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Package manager
  use 'wbthomason/packer.nvim'

  -- Mason and mason-lspconfig to manage lspconfig
  use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  }

  -- Fuzzy finder
  use {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    requires = {
      -- Core dependency
      { 'nvim-lua/plenary.nvim' },

      -- Optional: Improve sorting performance with native FZF extension
      { 'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make' -- Build FZF extension (alternatively use cmake)
      },

      -- Optional: For using fd with find_files and rg with live_grep
      { 'sharkdp/fd' },
      { 'BurntSushi/ripgrep' },

      -- Optional: Tree-sitter for better syntax highlighting in Telescope preview
      { 'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate' -- Update Tree-sitter after install
      },

      -- Optional: File icons for better visual clarity
      { 'nvim-tree/nvim-web-devicons' },

      -- Optional: Symbols picker for emoji, math, and more
      { 'nvim-telescope/telescope-symbols.nvim' },

      -- Optional: Clipboard manager
      { 'AckslD/nvim-neoclip.lua',
        requires = {
          { 'tami5/sqlite.lua', module = 'sqlite' },
        },
      },

      -- Optional: Cheatsheet
      {
        'doctorfree/cheatsheet.nvim',
        requires = {
          { 'nvim-lua/popup.nvim' },
        },
      }
    }
  }
end)
