-- Load the which key plug in
local whichKey = require('which-key')

-- Setup
whichKey.setup({
})

-- Keymap
vim.api.nvim_set_keymap('n', '<leader>?', ':WhichKey<CR>', { noremap = true, silent = true })
