-- Load neo scroll plug-in
local neoscroll = require('neoscroll')

-- Setup
neoscroll.setup({
  -- Adjust the speed of scrolling
  scroll_speed = 25, -- Controls how fast the scroll happens. Larger values = faster scroll.

  -- Customize animations
  mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>' },
  hide_cursor = true,
  stop_eof = true,
  respect_scrolloff = true,

  -- Optionally adjust easing animation style
  easing_function = "quadratic", -- Other options: "linear", "circular", "quadratic", etc.
})
