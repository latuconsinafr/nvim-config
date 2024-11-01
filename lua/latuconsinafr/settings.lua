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
vim.opt.list = true
vim.opt.listchars:append('lead:⋅')

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
