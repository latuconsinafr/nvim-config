return {
  "rmagatti/goto-preview",  -- Plugin for previewing definitions, implementations, etc., in a floating window
  dependencies = {
    "rmagatti/logger.nvim", -- Optional dependency used internally by goto-preview for logging
  },
  event = "BufEnter",       -- Lazy-load the plugin when entering a buffer (efficient startup)
  config = function()
    require("goto-preview").setup({
      default_mappings = true, -- Enables default keymaps:
      -- gpd → Preview definition
      -- gpt → Preview type definition
      -- gpi → Preview implementation
      -- gpD → Close all previews
    })
  end,
}
