return {
  "folke/which-key.nvim",      -- Plugin repo for which-key.nvim
  event = "VeryLazy",          -- Load plugin on VeryLazy event (after startup)
  opts = {
    -- Configuration options for which-key can be placed here.
    -- Leave empty for defaults or customize as needed.
  },
  keys = {
    {
      "<leader>?",             -- Keybinding to trigger which-key popup
      function()
        -- Show buffer-local keymaps only (not global mappings)
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",  -- Description shown in which-key menu
    },
  },
}

