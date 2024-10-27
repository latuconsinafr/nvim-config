-- Ensure packer is loaded
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Package manager
  use 'wbthomason/packer.nvim'

  -- Mason and mason-lspconfig to manage lspconfig
  use {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'neovim/nvim-lspconfig',
  }

  -- Completion
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',    -- LSP completion source
      'hrsh7th/cmp-buffer',      -- Buffer completion source
      'hrsh7th/cmp-path',        -- Path completion source
      'hrsh7th/cmp-cmdline',     -- Command line completion source
      'L3MON4D3/LuaSnip',        -- Lua snippet
      'saadparwaiz1/cmp_luasnip' -- Snippet completion source
    },
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
    },

    -- File explorer
    use {
      'nvim-tree/nvim-tree.lua',
      requires = {
        'nvim-tree/nvim-web-devicons', -- Optional: file icons for better visual clarity
      },
    },

    -- Auto pair
    use {
      'windwp/nvim-autopairs',
      event = 'InsertEnter',
      config = function()
        require('nvim-autopairs').setup {}
      end
    },

    -- Comments
    use 'terrortylor/nvim-comment',
    use {
      "danymat/neogen",
      requires = {
        -- Optional: Tree-sitter for better syntax highlighting in Telescope preview
        { 'nvim-treesitter/nvim-treesitter',
          run = ':TSUpdate' -- Update Tree-sitter after install
        },
      },
      config = function()
        require('neogen').setup {}
      end,
      tag = "*"
    },

    -- Lua line
    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    },

    -- Color scheme/theme
    use {
      'rose-pine/neovim',
      as = 'rose-pine',
    },

    -- Focus mode
    use 'folke/twilight.nvim',

    -- Notify
    use 'rcarriga/nvim-notify',

    -- Go to preview
    use {
      'rmagatti/goto-preview',
      config = function()
        require('goto-preview').setup {}
      end
    },

    -- Terminal
    use { "akinsho/toggleterm.nvim", tag = '*', config = function()
      require("toggleterm").setup()
    end },

    -- Fold
    use { 'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async' }
  }
end)
