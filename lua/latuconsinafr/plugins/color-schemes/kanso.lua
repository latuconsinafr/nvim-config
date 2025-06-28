return {
  {
    "webhooked/kanso.nvim", -- The kanso colorscheme plugin repo
    name = "kanso",         -- Name for easy reference inside lazy.nvim

    -- Load this colorscheme plugin eagerly during startup,
    -- important if this is your main colorscheme so it applies immediately
    lazy = false,

    -- Priority ensures this plugin loads before other plugins,
    -- which can be important for colorscheme to properly override highlights
    priority = 1000,

    -- Configuration function that runs after plugin is loaded
    config = function()
      -- Setup rose-pine with custom options
      require('kanso').setup({
        theme = "zen",
        italics = false, -- enable italics
      })

      -- Apply the colorscheme to Neovim
      -- vim.cmd([[colorscheme kanso]])
    end,
  }
}
