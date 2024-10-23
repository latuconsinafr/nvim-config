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
      { 'nvim-lua/plenary.nvim' }, -- Core dependency for telescope
      -- BurntSushi/ripgrep for live_grep and grep_string
      { 'nvim-telescope/telescope-fzf-native.nvim', -- Improve sorting performance
        run = 'make' -- alternatively use cmake
      },
      -- sharkdp/fd for finder 
      {
        -- Note: :TSUpdate will cause Packer to fail upon the first installation
        'nvim-treesitter/nvim-treesitter', -- Finder/Preview
        run = ':TSUpdate'
      }
      -- Optional dependencies: devicons
    }
  }
end)
