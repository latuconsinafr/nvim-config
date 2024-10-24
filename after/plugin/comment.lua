-- Load the plugin
local comment = require('nvim_comment')

comment.setup({
  comment_empty = false, -- Do not comment empty lines
  create_mappings = true, -- Create default mappings
})

-- Key mappings
vim.api.nvim_set_keymap('n', '<leader>c', ':CommentToggle<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>c', ':CommentToggle<CR>', { noremap = true, silent = true })
