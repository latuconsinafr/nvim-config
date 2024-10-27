local ufo = require('ufo')

-- Setup
ufo.setup({
  -- Option 3: treesitter as a main provider instead
  provider_selector = function(bufnr, filetype, buftype)
    return { 'treesitter', 'indent' } -- Use LSP or indentation-based folding
  end,
})

-- Keymaps
local opts = { noremap = true, silent = true }

vim.keymap.set('n', '<leader>za', 'za', opts) -- Toggle fold
vim.keymap.set('n', '<leader>zo', 'zo', opts) -- Open fold
vim.keymap.set('n', '<leader>zc', 'zc', opts) -- Close fold
vim.keymap.set('n', '<leader>zO', 'zR', opts) -- Open all folds

-- Optional: Customize folding behavior
vim.o.foldcolumn = '0'     -- Enable fold column
vim.o.foldlevel = 999      -- Set default fold level
vim.o.foldlevelstart = 999 -- Start with all folds open
vim.o.foldenable = true    -- Enable folds by default
