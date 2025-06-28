return {
  "RRethy/vim-illuminate", -- Plugin to highlight other uses of the word under the cursor
  event = "CursorHold",    -- Load on CursorHold event (can also use "VeryLazy" for deferred load)
  config = function()
    -- Configure the highlight groups used by vim-illuminate
    -- You can link these to any existing highlight group or define your own
    -- Here we link all of them to "Visual" for a consistent soft highlight style
    require("illuminate").configure({
      -- delay: delay in milliseconds
      delay = 200,
      -- under_cursor: whether or not to illuminate under the cursor
      under_cursor = false,
    })

    vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "Visual" })  -- Normal text matches
    vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "Visual" })  -- Read operations (like variables being read)
    vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "Visual" }) -- Write operations (like assignments)
  end,
}
