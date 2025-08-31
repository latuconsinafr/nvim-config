return {
  "folke/flash.nvim",
  event = "VeryLazy",
  ---@type Flash.Config
  opts = {
    jump = {
      auto_jump = false,
    },
    higlight = {
      matches = true,
      backdrop = false, -- Don't dim other text
    },
    label = {
      uppercase = false,
      after = true,           -- Show labels after the match (easier to see)
      min_pattern_length = 1, -- Show labels even for single characters
      style = "overlay",
    },
    search = {
      multi_window = false,
      wrap = false,
      max_length = 50, -- Limit search length to get better label visibility
    },
    modes = {
      search = {
        enabled = true,
        highlight = { backdrop = false },
      },
      char = {
        enabled = true,
        highlight = { backdrop = false },
        multi_line = true,
        jump_labels = true, -- Always show labels for character search
      },
    },
  },
  keys = {
    -- Use 'gl' (go-leap) - intuitive and rarely used
    { "gl",    mode = { "n", "x" }, function() require("flash").jump() end,       desc = "Flash Jump" },
    { "gL",    mode = { "n", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },

    -- Operator mode
    { "gl",    mode = "o",          function() require("flash").jump() end,       desc = "Flash Jump (operator)" },
    { "gL",    mode = "o",          function() require("flash").treesitter() end, desc = "Flash Treesitter (operator)" },

    -- Command mode toggle
    { "<c-s>", mode = { "c" },      function() require("flash").toggle() end,     desc = "Toggle Flash Search" },
  },
}

