-- Load telesope with its actions and builtin
local telescope = require('telescope')
local actions = require('telescope.actions')
local builtin = require('telescope.builtin')

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
    prompt_prefix = " Search > ",
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
  }
}

-- Load telescope extensions


-- Keymaps
local opts = { noremap = true, silent = true }

vim.keymap.set('n', '<leader>ff', builtin.find_files, opts) -- Find files
vim.keymap.set('n', '<leader>fg', builtin.live_grep, opts) -- Live grep search
vim.keymap.set('n', '<leader>fb', builtin.buffers, opts) -- List open buffers
vim.keymap.set('n', '<leader>fh', builtin.help_tags, opts) -- Help tags
vim.keymap.set('n', '<leader>fc', builtin.colorscheme, opts) -- Switch colorscheme
