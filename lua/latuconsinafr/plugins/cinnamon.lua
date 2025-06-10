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
    -- Define scroll options explicitlyAdd commentMore actions
    local scroll_opts = {
      delay = 7,
      step_size = { horizontal = 1 },
      max_delta = { line = 100, column = 150 },
      mode = "cursor", -- Can be "cursor", or "window"
    }

    -- Custom keymaps for animated word motionsAdd commentMore actions
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
