return {
  "lukas-reineke/indent-blankline.nvim",  -- Plugin repository
  main = "ibl",                           -- Use the new ibl API entry point
  event = { "BufReadPre", "BufNewFile" }, -- Load plugin on buffer read or new file (lazy loading)

  config = function()
    -- Setup indent-blankline.nvim (ibl) with custom options
    require("ibl").setup({
      indent = {
        char = "▏", -- Character used for indentation guides (thin vertical bar)
        highlight = "IndentBlanklineChar", -- Highlight group for indent guides
      },
      scope = {
        enabled = true,                    -- Enable scope highlighting (highlight current code block)
        show_start = true,                 -- Show the start of the current scope
        show_end = true,                   -- Show the end of the current scope
        highlight = "IndentBlanklineChar", -- Use same highlight group for scope guides
      },
    })

    -- Define the highlight group for indent guides AFTER setup,
    -- to avoid errors about missing highlight groups
    vim.api.nvim_set_hl(0, "IndentBlanklineChar", { fg = "#AAAAAA" }) -- Set indent guide color to light gray
  end,
}
