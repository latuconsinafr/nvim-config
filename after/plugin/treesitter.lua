local treesitter = require('nvim-treesitter.configs')
local context = require('treesitter-context')

-- Setup
treesitter.setup {
  -- A list of parser names, or "all" (the listed parsers MUST always be installed)
  ensure_installed = { "lua", "javascript", "typescript", "rust" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ign
  highlight = {
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },

  -- Automatic indentation
  indentation = {
    enable = true
  },

  -- Matchup
  matchup = {
    enable = true
  }
}

context.setup {
  enable = true,           -- Enable the context display
  throttle = true,         -- Optionally throttle the context display to improve performance
  max_lines = 5,           -- Show no more than this many lines of context (0 means infinite)
  trim_scope = 'outer',    -- Automatically trim context scope (class, method) from redundant display
  multiline_threshold = 5, -- collapse context lines if any scope line exceeds 5 lines
  mode = 'cursor',         -- Only show context for current cursor location
}
