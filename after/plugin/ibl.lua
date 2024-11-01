local highlight = {
  "CursorColumn",
  "Whitespace"
}

local ibl = require('ibl')

ibl.setup {
  indent = { highlight = highlight, char = "" },
  whitespace = {
    highlight = highlight,
  },
  scope = { enabled = false },
}
