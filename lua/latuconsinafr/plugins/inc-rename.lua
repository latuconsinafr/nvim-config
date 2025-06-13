return {
  -- Plugin: Incremental rename UI that updates as you type (like VSCode)
  "smjonas/inc-rename.nvim",

  -- Load only when the :IncRename command is called (lazy loading)
  cmd = "IncRename",

  config = function()
    require("inc_rename").setup({
      input_buffer_type = "popup", -- use "dressing" for dressing support
      show_message = true,         -- Whether to display a `Renamed m instances in n files` message after a rename operation
    })
    -- Keymap: Press <leader>rn to trigger rename for word under cursor
    vim.keymap.set("n", "<leader>rn", function()
      -- Prefill command-line with the current word under the cursor
      return ":IncRename " .. vim.fn.expand("<cword>")
    end, {
      expr = true,
      desc = "Incremental Rename" -- Description for which-key or other plugins
    })
  end,
}
