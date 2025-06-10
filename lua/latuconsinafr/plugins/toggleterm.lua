return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      -- Size can be a number or function which is passed the current terminal
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
      open_mapping = [[<c-\>]], -- Ctrl+\ to toggle terminal
      hide_numbers = true,
      shade_filetypes = {},
      autochdir = true,         -- Automatically change to the directory of the active buffer
      shade_terminals = true,   -- Apply a shading effect to the terminal
      shading_factor = 2,       -- Degree of shading (1-3)
      start_in_insert = true,   -- Start terminal in insert mode
      insert_mappings = true,   -- Allow terminal to be closed in insert mode with the configured toggle key
      persist_size = true,      -- Retain terminal size across sessions
      persist_mode = true,
      direction = 'horizontal', -- Choose between 'horizontal', 'vertical', 'tab', or 'float'
      close_on_exit = true,     -- Close the terminal when the process exits
      shell = vim.o.shell,
      auto_scroll = true,
    })

    -- Custom keymaps
    local map = vim.keymap.set

    -- Terminal mode mappings
    function _G.set_terminal_keymaps()
      local opts = { buffer = 0 }

      map('t', '<esc>', [[<C-\><C-n>]], opts)
      map('t', 'jk', [[<C-\><C-n>]], opts)
      map('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
      map('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
      map('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
      map('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
      map('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
    end

    -- Apply terminal keymaps
    vim.cmd("autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()")
  end,
}
