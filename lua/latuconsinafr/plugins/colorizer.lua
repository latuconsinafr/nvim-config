return {
  "catgoose/nvim-colorizer.lua",
  event = "BufReadPre",
  opts = {
    filetypes = { "*", "!lazy" }, -- Enable for all files except lazy UI
    user_default_options = {
      RGB      = true,
      RRGGBB   = true,
      names    = false,
      css      = false,
      tailwind = false,
      mode     = "background", -- or "foreground" or "virtualtext"
    },
  },
  config = function(_, opts)
    require("colorizer").setup(opts)
  end
}
