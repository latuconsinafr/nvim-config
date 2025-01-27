local rosepine = require('rose-pine')

-- Setup
rosepine.setup({
  variant = "auto",      -- auto, main, moon, or dawn
  dark_variant = "main", -- main, moon, or dawn

  styles = {
    bold = false,
    italic = false,
    transparency = true,
  },
})

vim.cmd('colorscheme rose-pine')
vim.opt.fillchars:append({ eob = ' ' }) -- Remove the ~ 
