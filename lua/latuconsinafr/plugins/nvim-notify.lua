return {
  {
    "rcarriga/nvim-notify",
    lazy = false, -- Load eagerly so it's ready immediately
    config = function()
      require("notify").setup({
        timeout = 500,  -- Timeout to exit
        stages = "fade_in_slide_out", -- Or "slide", "fade_in_slide_out", "static"
      })
    end,
  }
}
