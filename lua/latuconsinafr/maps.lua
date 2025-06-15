-- Set the leader key
vim.g.mapleader = " "

-- Source the init.lua
vim.keymap.set('n', '<leader>sv', ':source ~/.config/nvim/init.lua<CR>', { silent = true })

-- Source current file
vim.keymap.set("n", "<leader><leader>", function()
  vim.cmd("so")
end)

-- File Explorer
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Moving selected lines in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Combining lines without losing cursor position
vim.keymap.set("n", "J", "mzJ`z")

-- Smooth scrolling
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Search centering
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Replace pasting in visual mode
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Clipboard operations, copy to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Delete without yanking
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- Escape using <C-c> in insert mode
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Disable unused map
vim.keymap.set("n", "Q", "<nop>")

-- Navigating quickfix and location lists
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Find and replace word
vim.keymap.set("n", "<leader>rw", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>rwc", [[:.,$s/\<<C-r><C-w>\>/<C-r><C-w>/gc<Left><Left><Left>]])
vim.keymap.set("n", "<leader>rg", [[:%s//gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>rgc", [[:.,$s//gc<Left><Left><Left>]])

vim.keymap.set("v", "<leader>rs", function()
  vim.cmd('normal! "vy')
  local text = vim.fn.getreg("v")
  text = vim.fn.escape(text, [[\/]])
  vim.cmd('normal! :%s/' .. text .. '/' .. text .. '/gI')
end, { desc = "Replace selected text globally" })

vim.keymap.set("v", "<leader>rsc", function()
  vim.cmd('normal! "vy')
  local text = vim.fn.getreg("v")
  text = vim.fn.escape(text, [[\/]])
  vim.cmd('normal! :%s/' .. text .. '/' .. text .. '/gc')
end, { desc = "Replace selected text with confirm" })

-- Find and delete
vim.keymap.set("n", "<leader>fd", [[:g/\<C-r><C-w\>/d<CR>]])
vim.keymap.set("n", "<leader>sd", [[:g//d<Left><Left>]])

-- Force reload current file
vim.keymap.set('n', '<leader>r', ':e!<CR>')
