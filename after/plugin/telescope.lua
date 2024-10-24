-- Load telescope with its actions and builtin
local telescope = require('telescope')
local actions = require('telescope.actions')
local builtin = require('telescope.builtin')

-- Additional extension
local neoclip = require('neoclip')

-- Telescope setup
telescope.setup {
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
      }
    },
    prompt_prefix = " 🔍 ",
    selection_caret = "  ",
    file_ignore_patterns = { "node_modules", "bower_components", "%.code-search$", "^.git/" },
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
    find_files = {
      hidden = true, -- Include hidden files (files that start with a dot, such as .gitignore, .env, etc.)
    },
    live_grep = {},
    buffers = {},
    help_tags = {},
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case"
    },
    symbols = {

    }
  }
}

-- Load telescope extensions
telescope.load_extension('fzf')
-- telescope.load_extension('symbols')
telescope.load_extension('neoclip')
telescope.load_extension('cheatsheet')

-- Setup additional extensions
neoclip.setup({
  keys = {
    telescope = {
      i = {
        delete = '<nop>', -- Disable delete
      },
      n = {
        delete = '<nop>', -- Disable delete
      }
    }
  }
})

-- Keymaps
local opts = { noremap = true, silent = true }

-- File pickers
vim.keymap.set('n', '<leader>ff', builtin.find_files, opts)  -- Find files
vim.keymap.set('n', '<leader>fg', builtin.git_files, opts)   -- Git files
vim.keymap.set('n', '<leader>fs', builtin.grep_string, opts) -- Grep string under cursor
vim.keymap.set('n', '<leader>fl', builtin.live_grep, opts)   -- Live grep search
vim.keymap.set('n', '<leader>fl', builtin.live_grep, opts)   -- Live grep search

-- Vim pickers
vim.keymap.set('n', '<leader>fb', builtin.buffers, opts)         -- List open buffers
vim.keymap.set('n', '<leader>fo', builtin.oldfiles, opts)        -- List previously open files
vim.keymap.set('n', '<leader>fh', builtin.help_tags, opts)       -- Help tags
vim.keymap.set('n', '<leader>fk', builtin.keymaps, opts)         -- List normal mode keymappings
vim.keymap.set('n', '<leader>fc', builtin.command_history, opts) -- List command that were executed recently

-- Neovim LSP pickers
vim.keymap.set('n', '<leader>lr', builtin.lsp_references, opts)        -- Lists LSP references for word under the cursor
vim.keymap.set('n', '<leader>lI', builtin.lsp_incoming_calls, opts)    -- Lists LSP incoming calls for word under the cursor
vim.keymap.set('n', '<leader>lO', builtin.lsp_outgoing_calls, opts)    -- Lists LSP outgoing calls for word under the cursor
vim.keymap.set('n', '<leader>ls', builtin.lsp_document_symbols, opts)  -- Lists LSP document symbols in the current buffer
vim.keymap.set('n', '<leader>lS', builtin.lsp_workspace_symbols, opts) -- Lists LSP document symbols in the current workspace
vim.keymap.set('n', '<leader>ldg', builtin.diagnostics, opts)          -- Lists Diagnostics for all open buffers or a specific buffer. Use option bufnr=0 for current buffer
vim.keymap.set('n', '<leader>li', builtin.lsp_implementations, opts)   -- Goto the implementation of the word under the cursor if there's only one, otherwise show all options in Telescope
vim.keymap.set('n', '<leader>ld', builtin.lsp_definitions, opts)       -- Goto the definition of the word under the cursor, if there's only one, otherwise show all options in Telescope
vim.keymap.set('n', '<leader>lt', builtin.lsp_type_definitions, opts)  -- Goto the definition of the type of the word under the cursor, if there's only one, otherwise show all options in Telescope

-- Git pickers
vim.keymap.set('n', '<leader>gc', builtin.git_commits, opts)   -- Lists git commits with diff preview
vim.keymap.set('n', '<leader>gbc', builtin.git_bcommits, opts) -- Lists buffer's git commits with diff preview and checks them out on
vim.keymap.set('n', '<leader>gb', builtin.git_branches, opts)  -- Lists all branches with log preview
vim.keymap.set('n', '<leader>gs', builtin.git_status, opts)    -- Lists current changes per file with diff preview and add action
vim.keymap.set('n', '<leader>gst', builtin.git_stash, opts)    -- Lists stash items in current repository with ability to apply them on

-- Treesitter pickers
vim.keymap.set('n', '<leader>st', builtin.treesitter, opts) -- Lists Function names, variables, from Treesitter

-- Telescope symbols
vim.keymap.set('n', '<leader>ss', ':Telescope symbols<CR>', opts) -- Lists of all available symbols

-- Telescope clipboard manager
vim.keymap.set('n', '<leader>cp', ':Telescope neoclip<CR>', opts) -- Lists of all clips

-- Telescope cheatsheet
vim.keymap.set('n', '<leader>?', ':Telescope cheatsheet<CR>', opts) -- Lists of all cheatsheets command
