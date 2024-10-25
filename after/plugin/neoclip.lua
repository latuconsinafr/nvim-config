local neoclip = require('neoclip')

-- Setup
neoclip.setup({
  history = 1000,
  enable_persistent_history = true,
  continuous_sync = true,
  db_path = vim.fn.stdpath("data") .. "/databases/neoclip.sqlite3",
  on_paste = {
    set_reg = false,
    move_to_front = false,
    close_telescope = true,
  },
  keys = {
    telescope = {
      i = {
        select = '<nop>',       -- Press enter to select
        paste = '<cr>',         -- This will paste into your buffer (you may want to change this)
        paste_behind = '<nop>', -- Paste behind cursor
        replay = '<nop>',       -- Replay a macro
        delete = '<nop>',       -- Delete an entry
        edit = '<nop>',         -- Edit an entry
        custom = {},
      },
      n = {
        select = '<nop>',       -- Press enter to select
        paste = '<cr>',         -- This pastes immediately
        paste_behind = '<nop>', -- Paste behind cursor
        replay = '<nop>',       -- Replay a macro
        delete = '<nop>',       -- Delete an entry
        edit = '<nop>',         -- Edit an entry
        custom = {},
      },
    },
  },
})
