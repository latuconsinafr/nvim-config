return {
  "nvzone/showkeys",
  event = "VeryLazy",
  config = function()
    -- Setup plugin
    require("showkeys").setup({
      winopts = {
        relative = "editor",
        style = "minimal",
        border = "single",
        height = 1,
        row = 1,
        col = 0,
        zindex = 100,
      },

      winhl = "FloatBorder:Comment,Normal:Normal",

      timeout = 1, -- in seconds
      maxkeys = 3,
      show_count = true,
      excluded_modes = { "i" }, -- don't show in insert mode

      -- bottom-left, bottom-right, bottom-center, top-left, top-right, top-center
      position = "top-right",

      keyformat = {
        ["<BS>"] = "󰁮 ",
        ["<CR>"] = "󰘌",
        ["<Space>"] = "󱁐",
        ["<Up>"] = "󰁝",
        ["<Down>"] = "󰁅",
        ["<Left>"] = "󰁍",
        ["<Right>"] = "󰁔",
        ["<PageUp>"] = "Page 󰁝",
        ["<PageDown>"] = "Page 󰁅",
        ["<M>"] = "Alt",
        ["<C>"] = "Ctrl",
      },
    })

    vim.keymap.set("n", "<leader>sk", function()
      require("showkeys").toggle()
    end, { desc = "Toggle ShowKeys" })
  end,
}
