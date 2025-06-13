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
    vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
    vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
    vim.keymap.set("n", "<c-p>", "<Plug>(YankyPreviousEntry)")
    vim.keymap.set("n", "<c-n>", "<Plug>(YankyNextEntry)")
    vim.keymap.set("n", "<leader>p", ":YankyRingHistory<CR>", { desc = "Open Yanky ring history" })
  end,
}
