-- General & File Operations
-- Set the leader key
vim.g.mapleader = " "

-- Source the entire init.lua config
vim.keymap.set('n', '<leader>sv', ':source ~/.config/nvim/init.lua<CR>', { silent = true, desc = "Source init.lua" })

-- Source current file (shortcut for quick setting)
vim.keymap.set("n", "<leader><leader>", function()
  vim.cmd("so")
end, { desc = "Source current file" })

-- File explorer (open netrw at current path)
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Open file explorer (netrw)" })

-- Force reload current buffer from disk
vim.keymap.set('n', '<leader>rr', ':e!<CR>', { desc = "Force reload current file" })

-- Text Editing
-- Move selected lines up/down in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up (centered)" })

-- Search next/previous and center cursor
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })

-- Replace visual selection without overwriting default register
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste over (no yank)" })

-- Delete without affecting registers
vim.keymap.set("n", "d", [["_d]], { desc = "Delete (no yank)" })
vim.keymap.set("n", "dd", [["_dd]], { desc = "Delete line (no yank)" })
vim.keymap.set("x", "d", [["_d]], { desc = "Delete selection (no yank)" })

-- Change without affecting registers
vim.keymap.set("n", "c", [["_c]], { desc = "Change (no yank)" })
vim.keymap.set("n", "cc", [["_cc]], { desc = "Change line (no yank)" })
vim.keymap.set("x", "c", [["_c]], { desc = "Change selection (no yank)" })

-- Substitute without affecting registers
vim.keymap.set("n", "s", [["_s]], { desc = "Substitute character (no yank)" })
vim.keymap.set("n", "S", [["_S]], { desc = "Substitute line (no yank)" })
vim.keymap.set("x", "s", [["_s]], { desc = "Substitute selection (no yank)" })

-- Insert mode escape
vim.keymap.set("i", "<C-c>", "<Esc>", { desc = "Escape insert mode" })

-- Disable accidental Q (recording mode)
vim.keymap.set("n", "Q", "<nop>", { desc = "Disable Q" })

-- Quickfix & Location List Navigation
-- Navigate quickfix list
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz", { desc = "Next quickfix item" })
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz", { desc = "Prev quickfix item" })

-- Navigate location list
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = "Next location list item" })
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = "Prev location list item" })

-- Toggle quickfix window
vim.keymap.set("n", "<leader>qf", function()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.bo[buf].filetype == "qf" then
      vim.cmd("cclose")
      return
    end
  end
  vim.cmd("copen")
end, { desc = "Toggle quickfix window" })

-- Replace quickfix item
vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function()
    -- Map `dd` locally in the quickfix window
    vim.keymap.set("n", "dd", function()
      -- 1) Which line the cursor is on? (1-based)
      local qf_line = vim.fn.line(".")

      -- 2) Get the entire quickfix list
      local qflist = vim.fn.getqflist()

      -- 3) Remove that entry from the Lua list (0-based index)
      table.remove(qflist, qf_line)

      -- 4) Replace the quickfix list with our new one
      --    Use the {} + 'r' + { items = ... } form
      vim.fn.setqflist({}, "r", { items = qflist })

      -- 5) Re-open the quickfix window so it redraws
      vim.cmd("copen")

      -- 6) Jump cursor to the same line number (or last line if we removed the last)
      local new_qf_count = #qflist
      if new_qf_count == 0 then
        -- nothing left
        return
      end

      -- clamp the cursor between 1 and new_qf_count
      local new_line = math.min(qf_line, new_qf_count)
      vim.api.nvim_win_set_cursor(0, { new_line, 0 })
    end, {
      buffer = true,
      desc   = "Remove this entry from the quickfix list",
    })
  end,
})

-- Search & Replace
-- Replace current word globally (no confirm)
vim.keymap.set("n", "<leader>rw", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "Replace word (global)" })

-- Replace current word from cursor to EOF (confirm)
vim.keymap.set("n", "<leader>rwc", [[:.,$s/\<<C-r><C-w>\>/<C-r><C-w>/gc<Left><Left><Left>]],
  { desc = "Replace word (confirm from here)" })

-- Replace arbitrary word globally (manual input)
vim.keymap.set("n", "<leader>rg", [[:%s//gI<Left><Left><Left>]], { desc = "Replace (manual global)" })

-- Replace arbitrary word with confirm from cursor to EOF
vim.keymap.set("n", "<leader>rgc", [[:.,$s//gc<Left><Left><Left>]], { desc = "Replace (manual confirm)" })

-- Replace only in quickfix lines (manual input - simple prompt)
vim.keymap.set("n", "<leader>rq",
  [[:cdo s//g | update<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>]],
  { desc = "Replace in quickfix lines only (manual)" })

-- Replace only in quickfix lines with confirmation (manual input)
vim.keymap.set("n", "<leader>rqc",
  [[:cdo s//gc | update<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>]],
  { desc = "Replace in quickfix lines only (manual confirm)" })

-- Replace arbitrary pattern globally in quickfix
vim.keymap.set("n", "<leader>rqg",
  [[:cfdo %s//gI | update<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>]],
  { desc = "Replace in quickfix (manual global)" })

-- Replace arbitrary pattern with confirm in quickfix
vim.keymap.set("n", "<leader>rqgc",
  [[:cfdo %s//gc | update<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>]],
  { desc = "Replace in quickfix (manual confirm)" })

-- Find & Delete
-- Delete all lines containing current word
vim.keymap.set("n", "<leader>dw", [[:g/\<<C-r><C-w>\>/d<CR>]], { desc = "Delete lines containing word" })

-- Delete all lines matching last search
vim.keymap.set("n", "<leader>df", [[:g//d<Left><Left>]], { desc = "Delete lines matching search" })
