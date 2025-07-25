return {
  -- Plugin repository and version to use
  "declancm/cinnamon.nvim",
  version = "*", -- Use the latest release version

  -- Enabled/Disabled
  enabled = true,

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
        delay = 5, -- Delay in milliseconds between scroll steps (smoothness)

        -- Maximum allowed scroll delta before instant jump instead of smooth scroll
        max_delta = {
          line = 30,   -- Max lines to scroll smoothly, beyond this jumps instantly
          column = false, -- Max columns to scroll smoothly, beyond this jumps instantly
        },
      },
    })

    -- Define scroll options explicitly
    local scroll_opts = {
      delay = 5,
      step_size = {
        -- Number of cursor/window lines moved per step
        vertical = 1,
        -- Number of cursor/window columns moved per step
        horizontal = 2,
      },
      max_delta = { line = 30, column = false },
      mode = "cursor", -- Can be "cursor", or "window"
    }

    -- Custom keymaps for animated word motions
    vim.keymap.set("n", "w", function()
      cinnamon.scroll("w", scroll_opts)
    end, { noremap = true, silent = true })

    vim.keymap.set("n", "b", function()
      cinnamon.scroll("b", scroll_opts)
    end, { noremap = true, silent = true })

    vim.keymap.set("n", "e", function()
      cinnamon.scroll("e", scroll_opts)
    end, { noremap = true, silent = true })
  end,
}
