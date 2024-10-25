local twilight = require('twilight')

-- Setup
twilight.setup{
  dimming = {
    alpha = 0.25, -- amount of dimming (0.0 - 1.0)
    inactive = true -- dim inactive windows
  },
  context = 5, -- amount of lines we will try to show around the current line
  treesitter = true, -- use treesitter when available for the filetype
  expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
    'function',
    'method',
    'table',
    'if_statement',
  },
}

-- Keymaps 
vim.keymap.set('n', '<leader>tw', ':Twilight<CR>', { noremap = true, silent = true })
