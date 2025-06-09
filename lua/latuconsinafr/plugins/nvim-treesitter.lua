return {
  {
    -- Main Treesitter plugin for better syntax highlighting, indentation, etc.
    "nvim-treesitter/nvim-treesitter",
    -- Load this plugin eagerly on startup
    lazy = false,                       
    -- Run :TSUpdate after install to keep parsers updated
    build = ":TSUpdate",
    -- Lazy-load when opening or creating a file
    event = { "BufReadPost", "BufNewFile" },

    -- Optional dependencies to enhance Treesitter functionality
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects", -- Better syntax-aware motions & selections
      "nvim-treesitter/nvim-treesitter-context",     -- Sticky header showing current scope
      "andymass/vim-matchup",                        -- Vim plugin for enhanced % matching (optional but recommended)
    },

    config = function()
      -- Optional warning if tree-sitter CLI is not found
      if vim.fn.executable("tree-sitter") == 0 then
        vim.notify("tree-sitter CLI not found. Run `npm install -g tree-sitter-cli` for auto parser install.", vim.log.levels.WARN)
      end

      -- Setup treesitter-context (shows scope like function/class at top of window)
      require("treesitter-context").setup {
        enable = true,           -- Enable the context module
        throttle = true,         -- Improve performance by throttling updates
        max_lines = 5,           -- Max lines of context to show (0 = infinite)
        trim_scope = "outer",    -- Trim outermost context if too many
        mode = "cursor",         -- Show context based on cursor position
      }

      -- Matchup settings
      vim.g.matchup_matchparen_enabled = 1                      -- Ensure matchparen is enabled
      vim.g.matchup_matchparen_deferred = 1                     -- Enable deferred matching for performance
      vim.g.matchup_matchparen_hi_surround_always = 1           -- Always highlight surrounding brackets
      vim.g.matchup_override_vimtex = 1                         -- If you're using LaTeX, enable special handling
      vim.g.matchup_matchparen_offscreen = { method = "popup" } -- Bring off-screen matches into view

      -- Setup core Treesitter config
      require("nvim-treesitter.configs").setup {
        -- Leave empty to allow dynamic installation of any language parser
        ensure_installed = {},

        -- Automatically install missing parsers when entering a buffer
        auto_install = true,

        -- Don't block editor waiting for parser installs
        sync_install = false,

        -- Syntax highlighting using Treesitter
        highlight = {
          enable = true,                              -- Enable highlighting
          additional_vim_regex_highlighting = false,  -- Avoid duplicate highlights
        },

        -- Enable smarter indentation
        indent = {
          enable = true,
        },

        -- Enable smarter matching (like % movement)
        matchup = {
          enable = true,
        },
      }
    end,
  },
}

