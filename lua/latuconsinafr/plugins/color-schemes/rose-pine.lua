return {
  {
    "rose-pine/neovim",     -- The rose-pine colorscheme plugin repo
    name = "rose-pine",     -- Name for easy reference inside lazy.nvim
    
    -- Load this colorscheme plugin eagerly during startup,
    -- important if this is your main colorscheme so it applies immediately
    lazy = false,
    
    -- Priority ensures this plugin loads before other plugins,
    -- which can be important for colorscheme to properly override highlights
    priority = 1000,
    
    -- Configuration function that runs after plugin is loaded
    config = function()
      -- Setup rose-pine with custom options
      require('rose-pine').setup({
        variant = "auto",          -- Automatically switch between light/dark variants based on system or time
        dark_variant = "main",     -- Choose the main dark variant when in dark mode
        
        styles = {
          bold = false,            -- Disable bold text styles
          italic = false,          -- Disable italic text styles
        },
      })
      
      -- Apply the colorscheme to Neovim
      vim.cmd([[colorscheme rose-pine]])
    end,
  },
}

