-- Import the nvim-tree module
local tree = require('nvim-tree')

-- Function to resize Nvim Tree (note: global function, be aware)
_G.resize_nvim_tree = function(amount)
  local current_width = vim.api.nvim_win_get_width(0)
  local new_width = current_width + amount

  vim.cmd("NvimTreeResize " .. new_width)
end

-- Setup the nvim-tree configuration
tree.setup({
  -- Sort by case sensitivity
  sort_by = "case_sensitive",
  view = {
    -- Set the width of the tree view
    width = 30,
  },
  renderer = {
    -- Group empty folders together
    group_empty = true,
    icons = {
      show = {
        file = true,         -- Show file icons
        folder = true,       -- Show folder icons
        folder_arrow = true, -- Show folder arrow icons
        git = true,          -- Show git icons
      },
    },
  },
  filters = {
    dotfiles = false, -- Show dotfiles
    custom = {        -- Custom filters to ignore certain files
      "^.git$",
      "^.svn$",
      "^.hg$",
      "^CVS$",
      "^.DS_Store$",
      "^Thumbs.db$"
    }
  },
  git = {
    enable = true,  -- Enable git integration
    ignore = false, -- Do not ignore untracked files
    timeout = 500,  -- Timeout for git commands
  },
})

-- Keymap options
local opts = { noremap = true, silent = true }

-- Key mappings for Nvim Tree functionality
vim.api.nvim_set_keymap('n', '<leader>tt', ':NvimTreeToggle<CR>', opts)   -- Toggle Nvim Tree
vim.api.nvim_set_keymap('n', '<leader>tr', ':NvimTreeRefresh<CR>', opts)  -- Refresh Nvim Tree
vim.api.nvim_set_keymap('n', '<leader>tf', ':NvimTreeFindFile<CR>', opts) -- Find current file in Nvim Tree

-- Key mappings for resizing Nvim Tree
vim.api.nvim_set_keymap('n', '<leader>tl', ':lua resize_nvim_tree(5)<CR>', opts)  -- Increase size
vim.api.nvim_set_keymap('n', '<leader>th', ':lua resize_nvim_tree(-5)<CR>', opts) -- Decrease size
