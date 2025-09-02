return {
  "folke/flash.nvim",
  event = "VeryLazy",
  ---@type Flash.Config
  opts = {
    jump = {
      auto_jump = false,
    },
    highlight = {
      matches = true,
      backdrop = true, -- Dim other text
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
    -- Flash jump forward only
    { "gl",    mode = { "n", "x" }, function() require("flash").jump({ search = { forward = true } }) end,  desc = "Flash Jump Forward" },
    -- Flash jump backward only
    { "gh",    mode = { "n", "x" }, function() require("flash").jump({ search = { forward = false } }) end, desc = "Flash Jump Backward" },
    -- Flash treesitter
    { "gL",    mode = { "n", "x" }, function() require("flash").treesitter() end,                           desc = "Flash Treesitter" },

    -- Operator mode
    { "gl",    mode = "o",          function() require("flash").jump({ search = { forward = true } }) end,  desc = "Flash Jump Forward (operator)" },
    { "gh",    mode = "o",          function() require("flash").jump({ search = { forward = false } }) end, desc = "Flash Jump Backward (operator)" },
    { "gL",    mode = "o",          function() require("flash").treesitter() end,                           desc = "Flash Treesitter (operator)" },

    -- Command mode toggle
    { "<c-s>", mode = { "c" },      function() require("flash").toggle() end,                               desc = "Toggle Flash Search" },
  },
}
