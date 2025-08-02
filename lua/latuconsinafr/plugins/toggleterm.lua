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
      autochdir = true,       -- Automatically change to the directory of the active buffer
      shade_terminals = true, -- Apply a shading effect to the terminal
      shading_factor = 2,     -- Degree of shading (1-3)
      start_in_insert = true, -- Start terminal in insert mode
      insert_mappings = true, -- Allow terminal to be closed in insert mode with the configured toggle key
      persist_size = true,    -- Retain terminal size across sessions
      persist_mode = true,
      direction = 'float',    -- Choose between 'horizontal', 'vertical', 'tab', or 'float'
      close_on_exit = true,   -- Close the terminal when the process exits
      shell = vim.o.shell,
      auto_scroll = true,
    })

    -- Terminal mode mappings
    function _G.set_terminal_keymaps()
      -- Exit terminal mode using <Esc>
      vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], { desc = "Exit terminal mode (ESC)", buffer = 0 })

      -- Exit terminal mode using 'jk'
      vim.keymap.set('t', 'jk', [[<C-\><C-n>]], { desc = "Exit terminal mode (jk)", buffer = 0 })

      -- Navigate to the left window from terminal
      vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], { desc = "Terminal window left", buffer = 0 })

      -- Navigate to the below window from terminal
      vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], { desc = "Terminal window down", buffer = 0 })

      -- Navigate to the above window from terminal
      vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], { desc = "Terminal window up", buffer = 0 })

      -- Navigate to the right window from terminal
      vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], { desc = "Terminal window right", buffer = 0 })

      -- Trigger normal mode and use window command
      vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], { desc = "Use <C-w> window commands from terminal", buffer = 0 })
    end

    -- Apply terminal keymaps
    vim.cmd("autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()")
  end,
}
