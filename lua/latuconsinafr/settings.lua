-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Use spaces instead of tabs
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2

-- Indentation 
vim.opt.smartindent = true

-- Enable clipboard access
vim.opt.clipboard = 'unnamedplus'

-- Search settings
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- UI enhancements
vim.opt.termguicolors = true

-- Scrolling and UI
vim.opt.scrolloff = 8
vim.opt.signcolumn = 'yes'
vim.opt.isfname:append('@-@')
vim.opt.cursorline = true

-- Performance
vim.opt.updatetime = 50

-- Fold options
vim.opt.foldmethod = 'syntax'

-- Remove the ~ at end of buffer
vim.opt.fillchars = { eob = ' ' }

-- Configure spell capabilities
vim.opt.spell = true
vim.opt.spelllang = { "en_gb" }

-- Clear any half‑typed keys on focus gain, without leaving your current mode
vim.api.nvim_create_autocmd("FocusGained", {
  callback = function()
    -- Flush type‑ahead but don’t send an actual <Esc>
    vim.fn.feedkeys("", "nx")
  end,
})
