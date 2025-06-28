return {
  {
    "rebelot/kanagawa.nvim", -- The kanagawa colorscheme plugin repo
    name = "kanagawa",       -- Name for easy reference inside lazy.nvim

    -- Load this colorscheme plugin eagerly during startup,
    -- important if this is your main colorscheme so it applies immediately
    lazy = false,

    -- Priority ensures this plugin loads before other plugins,
    -- which can be important for colorscheme to properly override highlights
    priority = 1000,

    -- Configuration function that runs after plugin is loaded
    config = function()
      -- Setup rose-pine with custom options
      require('kanagawa').setup({
        commentStyle = { italic = false },
        keywordStyle = { italic = false },
        statementStyle = { bold = false },
        theme = "dragon", -- Load "dragon" theme
        background = {    -- map the value of 'background' option to a theme
          dark = "wave",  -- try "dragon" !
          light = "lotus"
        },
      })

      -- Apply the colorscheme to Neovim
      -- vim.cmd([[colorscheme kanagawa]])
    end,
  }
}
