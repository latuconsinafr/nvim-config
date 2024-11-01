local toggleterm = require('toggleterm')

toggleterm.setup({
  -- size can be a number or function which is passed the current terminal
  size = function(term)
    if term.direction == 'horizontal' then
      return 10
    elseif term.direction == 'vertical' then
      return vim.o.columns * 0.4
    end
  end,
  open_mapping = [[<c-\>]], -- Keybinding to toggle terminal
  hide_numbers = true,      -- Hide the line numbers in terminal buffers
  shade_filetypes = {},
  autochdir = true,         -- Automatically change to the directory of the active buffer
  shade_terminals = true,   -- Apply a shading effect to the terminal
  shading_factor = 2,       -- Degree of shading (1-3)
  start_in_insert = true,   -- Start terminal in insert mode
  insert_mappings = true,   -- Allow terminal to be closed in insert mode with the configured toggle key
  persist_size = false,     -- Retain terminal size across sessions
  direction = 'horizontal', -- Choose between 'horizontal', 'vertical', 'tab', or 'float'
  close_on_exit = true,     -- Close the terminal when the process exits
  shell = vim.o.shell,      -- Use the default shell
  float_opts = {
    border = 'curved',      -- Choose from 'single', 'double', 'shadow', 'curved'
    winblend = 0,           -- Transparency level
    highlights = {
      border = 'Normal',
      background = 'Normal',
    },
  },
})

-- Keymaps
_G.set_terminal_keymaps = function()
  local opts = { buffer = 0 }

  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
