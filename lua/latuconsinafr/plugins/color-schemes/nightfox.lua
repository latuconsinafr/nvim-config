return {
  {
    "EdenEast/nightfox.nvim", -- The nightfox colorscheme plugin repo
    name = "nightfox", -- Name for easy reference inside lazy.nvim

    -- Load this colorscheme plugin eagerly during startup,
    -- important if this is your main colorscheme so it applies immediately
    lazy = false,

    -- Priority ensures this plugin loads before other plugins,
    -- which can be important for colorscheme to properly override highlights
    priority = 1000,

    -- Configuration function that runs after plugin is loaded
    config = function()
      -- Setup rose-pine with custom options
      require('nightfox').setup({
      })

      -- Apply the colorscheme to Neovim
      -- vim.cmd([[colorscheme duskfox]])
    end,
  },
}

