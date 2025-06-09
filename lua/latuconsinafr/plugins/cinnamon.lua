return {
  -- Plugin repository and version to use
  "declancm/cinnamon.nvim",
  version = "*", -- Use the latest release version

  -- Configuration function that runs after the plugin is loaded
  config = function()
    -- Load cinnamon module and setup with custom options
    local cinnamon = require("cinnamon")

    cinnamon.setup({
      -- Keymaps configuration
      keymaps = {
        basic = true, -- Enable basic keymaps (e.g., for scrolling)
        extra = true, -- Enable extra keymaps (like <C-u>, <C-d>, etc.)
      },

      -- Additional scrolling options
      options = {
        delay = 7, -- Delay in milliseconds between scroll steps (smoothness)

        -- Maximum allowed scroll delta before instant jump instead of smooth scroll
        max_delta = {
          line = 100,   -- Max lines to scroll smoothly, beyond this jumps instantly
          column = 150, -- Max columns to scroll smoothly, beyond this jumps instantly
        },
      },
    })
  end,
}
