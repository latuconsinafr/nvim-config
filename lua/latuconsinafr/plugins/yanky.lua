return {
  "gbprod/yanky.nvim",
  dependencies = {
    "kkharji/sqlite.lua",
  },
  config = function()
    require("yanky").setup({
      ring = {
        history_length = 250,
        storage = "sqlite",
        storage_path = vim.fn.stdpath("data") .. "/databases/yanky.db",
      },
      system_clipboard = {
        sync_with_ring = true,
      },
      highlight = {
        on_put = true,
        on_yank = true,
        timer = 100,
      },
    })

    -- Basic keymaps
    -- Paste after cursor using Yanky (preserves default register history)
    vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")

    -- Paste before cursor using Yanky
    vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")

    -- Cycle to previous yank in the yank history
    vim.keymap.set("n", "<C-p>", "<Plug>(YankyPreviousEntry)")

    -- Cycle to next yank in the yank history
    vim.keymap.set("n", "<C-n>", "<Plug>(YankyNextEntry)")

    -- Open a searchable popup list of past yanks (like a clipboard manager)
    vim.keymap.set("n", "<leader>p", ":YankyRingHistory<CR>", { desc = "Open Yanky ring history" })
  end,
}
