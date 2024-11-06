-- Load the go to preview plugin
local goto_preview = require('goto-preview')

-- Setup
goto_preview.setup {
  width = 100, -- Width of the floating window
  height = 15, -- Height of the floating window
  border = { "↖", "─", "┐", "│", "┘", "─", "└", "│" }, -- Border configuration
  default_mappings = false, -- You can use default keybindings or define your own
  opacity = nil, -- 0-100 transparency level, set to nil for no transparency
  stack_floating_preview_windows = false -- Whether to nest floating windows
}

-- Keymappings
local opts = { noremap = true, silent = true }

vim.keymap.set('n', 'gpd', '<cmd>lua require("goto-preview").goto_preview_definition()<CR>', opts)      -- Go to definition
vim.keymap.set('n', 'gpD', '<cmd>lua require("goto-preview").goto_preview_declaration()<CR>', opts)     -- Go to declaration
vim.keymap.set('n', 'gpr', '<cmd>lua require("goto-preview").goto_preview_references()<CR>', opts)      -- Find references
vim.keymap.set('n', 'gpi', '<cmd>lua require("goto-preview").goto_preview_implementation()<CR>', opts)  -- Go to implementation
vim.keymap.set('n', 'gpt', '<cmd>lua require("goto-preview").goto_preview_type_definition()<CR>', opts) -- Go to type definition
vim.keymap.set('n', 'gP', '<cmd>lua require("goto-preview").close_all_win()<CR>', opts)                 -- Close all
vim.keymap.set('n', '<Esc>', '<cmd>lua require("goto-preview").close_all_win()<CR>', opts)              -- Close all

-- Additional function
-- Function to close the current buffer and open it in a new split
_G.close_and_split = function()
  -- Get the current buffer number
  local bufnr = vim.api.nvim_get_current_buf()

  -- Close the current buffer
  vim.cmd('bd ' .. bufnr)   -- Close current buffer

  -- Open the same buffer in a new split
  vim.cmd('rightbelow vsplit ' .. vim.api.nvim_buf_get_name(bufnr))   -- Open in a new split
end

-- Key mapping to trigger the function
vim.api.nvim_set_keymap('n', '<leader>pw', ':lua close_and_split()<CR>', opts)
