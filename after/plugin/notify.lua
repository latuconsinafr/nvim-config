local notify = require('notify')

-- Setup
notify.setup({
  stages = "fade_in_slide_out",  -- Available: "fade", "fade_in_slide_out", "slide", "static"
  timeout = 1500,                -- Time the notification is visible (in ms)
  background_colour = "#000000", -- Optional: set background color
  icons = {
    ERROR = "",
    WARN  = "",
    INFO  = "",
    DEBUG = "",
    TRACE = "✎",
  }
})

-- Set notify as default for vim notifications
vim.notify = notify;

-- Keymaps
vim.keymap.set('n', '<leader>nh', notify.history, { noremap = true, silent = true })
