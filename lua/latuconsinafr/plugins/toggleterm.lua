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
      hide_numbers = true,
      shade_filetypes = {},
      autochdir = true,        -- Automatically change to the directory of the active buffer
      shade_terminals = true,  -- Apply a shading effect to the terminal
      shading_factor = 2,      -- Degree of shading (1-3)
      start_in_insert = true,  -- Start terminal in insert mode
      insert_mappings = false, -- Disabled to use custom toggle system
      persist_size = true,     -- Retain terminal size across sessions
      persist_mode = true,     -- if set to true (default) the previous terminal mode will be remembered
      direction = 'float',     -- Choose between 'horizontal', 'vertical', 'tab', or 'float'
      float_opts = {
        width = math.floor(vim.o.columns * 0.85),
        height = math.floor(vim.o.lines * 0.75),
        title_pos = 'center',
        border = 'curved',  -- Add border for better visibility
        winblend = 0,       -- No transparency issues
      },
      close_on_exit = true, -- Close the terminal when the process exits
      shell = vim.o.shell,
      auto_scroll = true,
      terminal_mappings = true,                               -- Apply terminal keymaps
      env = {
        COLUMNS = tostring(math.floor(vim.o.columns * 0.85)), -- Set proper column width
      },
      on_create = function(term)
        -- Set proper terminal options when created
        vim.cmd("setlocal wrap")            -- Enable text wrapping
        vim.cmd("setlocal linebreak")       -- Break at word boundaries
        vim.cmd("setlocal nolist")          -- Don't show whitespace chars
        vim.cmd("setlocal textwidth=0")     -- No hard text width limit
        vim.cmd("setlocal wrapmargin=0")    -- No wrap margin
        vim.cmd("setlocal sidescroll=0")    -- Don't scroll horizontally
        vim.cmd("setlocal sidescrolloff=0") -- No side scroll offset
      end,
    })

    local Terminal = require('toggleterm.terminal').Terminal

    -- Terminal instances with generic names
    local terminals = {
      Terminal:new({ count = 1, display_name = "Alpha" }),
      Terminal:new({ count = 2, display_name = "Beta" }),
      Terminal:new({ count = 3, display_name = "Gamma" }),
      Terminal:new({ count = 4, display_name = "Delta" }),
      Terminal:new({ count = 5, display_name = "Epsilon" }),
    }

    -- Function to toggle specific terminal
    function _G.toggle_terminal(num)
      if terminals[num] then
        terminals[num]:toggle()
      end
    end

    -- Keymaps for terminal management
    -- Main toggle (replaces Ctrl+\)
    vim.keymap.set({ 'n', 't' }, '<C-\\>', '<cmd>lua toggle_terminal(1)<CR>', { desc = "Toggle Alpha" })

    -- Individual terminal toggles
    vim.keymap.set({ 'n', 't' }, '\\1', '<cmd>lua toggle_terminal(1)<CR>', { desc = "Toggle Alpha" })
    vim.keymap.set({ 'n', 't' }, '\\2', '<cmd>lua toggle_terminal(2)<CR>', { desc = "Toggle Beta" })
    vim.keymap.set({ 'n', 't' }, '\\3', '<cmd>lua toggle_terminal(3)<CR>', { desc = "Toggle Gamma" })
    vim.keymap.set({ 'n', 't' }, '\\4', '<cmd>lua toggle_terminal(4)<CR>', { desc = "Toggle Delta" })
    vim.keymap.set({ 'n', 't' }, '\\5', '<cmd>lua toggle_terminal(5)<CR>', { desc = "Toggle Epsilon" })

    -- Terminal mode mappings
    function _G.set_terminal_keymaps()
      -- Switch to normal mode
      vim.keymap.set('t', '<C-q>', [[<C-\><C-n>]], { desc = "Switch to normal mode", buffer = 0 })

      -- Navigate to the left window from terminal
      vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], { desc = "Terminal window left", buffer = 0 })

      -- Navigate to the below window from terminal
      vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], { desc = "Terminal window down", buffer = 0 })

      -- Navigate to the above window from terminal
      vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], { desc = "Terminal window up", buffer = 0 })

      -- Navigate to the right window from terminal
      vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], { desc = "Terminal window right", buffer = 0 })
    end

    -- Apply terminal keymaps
    vim.cmd("autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()")
  end,
}
