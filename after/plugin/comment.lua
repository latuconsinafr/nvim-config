-- Load the plugin
local comment = require('nvim_comment')

-- Setup
comment.setup({
  comment_empty = false,  -- Do not comment empty lines
  create_mappings = true, -- Create default mappings
})

-- Key mappings
vim.keymap.set('n', '<leader>c', ':CommentToggle<CR>', { noremap = true, silent = true })
vim.keymap.set('v', '<leader>c', ':CommentToggle<CR>', { noremap = true, silent = true })
