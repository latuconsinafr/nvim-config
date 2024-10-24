local rosepine = require('rose-pine')

rosepine.setup({
  variant = "auto",      -- auto, main, moon, or dawn
  dark_variant = "main", -- main, moon, or dawn

  styles = {
    bold = false,
    italic = false,
    transparency = false,
  },
})

vim.cmd('colorscheme rose-pine')
vim.opt.fillchars:append({ eob = ' ' }) -- Remove the ~ 
