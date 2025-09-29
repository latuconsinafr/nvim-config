return {
  -- Plugin to handle safe buffer deletion (like closing tabs)
  {
    "echasnovski/mini.bufremove",
    version = "*",
    config = function()
      require("mini.bufremove").setup()
    end,
  },

  -- Bufferline plugin for showing open buffers like tabs
  {
    'akinsho/bufferline.nvim',
    version = "*",
    lazy = true,

    -- Load bufferline only when a normal buffer is opened
    init = function()
      vim.api.nvim_create_autocmd("BufWinEnter", {
        group = vim.api.nvim_create_augroup("LazyLoadBufferline", { clear = true }),
        callback = function(args)
          local ft = vim.bo[args.buf].filetype
          if ft ~= "NvimTree" and ft ~= "" then
            -- Load the plugin and remove this autocommand group
            vim.api.nvim_del_augroup_by_name("LazyLoadBufferline")
            vim.schedule(function()
              require("lazy").load({ plugins = { "bufferline.nvim" } })
            end)
          end
        end,
      })
    end,

    -- Required dependencies
    dependencies = {
      'nvim-tree/nvim-web-devicons', -- Icons for filetypes
      'echasnovski/mini.bufremove',  -- Handles safe buffer deletion
    },

    config = function()
      -- Custom function to delete buffer safely
      local function smart_buf_delete(bufnr)
        local normal_buffers = vim.tbl_filter(function(buf)
          return vim.api.nvim_buf_is_valid(buf)
              and vim.bo[buf].buflisted
              and vim.api.nvim_buf_get_name(buf) ~= ""
              and vim.bo[buf].filetype ~= "NvimTree"
        end, vim.api.nvim_list_bufs())

        -- If it's the last buffer, quit Neovim entirely
        if #normal_buffers == 1 and normal_buffers[1] == bufnr then
          vim.cmd("qa")
          return
        end

        require("mini.bufremove").delete(bufnr, false)
      end

      local bufferline = require("bufferline")

      bufferline.setup({
        options = {
          custom_filter = function(bufnr)
            local filetype = vim.bo[bufnr].filetype
            local bufname = vim.api.nvim_buf_get_name(bufnr)

            -- Hide quickfix, and any unwanted non-file buffers
            return filetype ~= "qf" and bufname ~= ""
          end,

          mode = "buffers",                    -- Use buffers instead of tabs
          numbers = "none",                    -- No buffer numbers shown
          themeable = true,                    -- Automatically adapts to your current colorscheme
          close_command = "bdelete! %d",       -- can be a string | function, | false see "Mouse actions"
          right_mouse_command = "bdelete! %d", -- can be a string | function | false, see "Mouse actions"
          left_mouse_command = "buffer %d",    -- can be a string | function, | false see "Mouse actions"
          middle_mouse_command = nil,          -- can be a string | function, | false see "Mouse actions"

          -- Buffer active indicator (left of buffer name)
          indicator = {
            icon = '▎',
            style = 'icon',
          },

          buffer_close_icon = '󰅖',
          modified_icon = '● ', -- Shown when buffer is modified
          left_trunc_marker = ' ', -- Shown when buffer name is truncated
          right_trunc_marker = ' ',
          tab_size = 12,
          max_name_length = 15,     -- Max buffer name shown
          max_prefix_length = 12,   -- Max prefix (used when buffers have same name)
          truncate_names = true,    -- Truncate long names

          diagnostics = "nvim_lsp", -- Show LSP diagnostics in tabs

          -- Offset config to integrate nicely with NvimTree
          offsets = {
            {
              filetype = "NvimTree",
              text = "File Explorer",
              text_align = "center",
              separator = true,
              highlight = "Directory"
            },
          },

          color_icons = true,             -- Use color icons (requires web-devicons)
          show_buffer_icons = true,
          show_buffer_close_icons = true, -- Hide individual buffer close icons
          show_close_icon = false,        -- Hide global close icon
          show_tab_indicators = true,     -- Show small indicator for active buffer
          show_duplicate_prefix = true,   -- Show file path prefix when there are duplicate filenames
          persist_buffer_sort = true,     -- whether or not custom sorted buffers should persist

          separator_style = "slant",      -- Can be "slant", "thick", "thin", or custom list

          -- Style presets: disable italics and bold text
          style_preset = {
            bufferline.style_preset.no_italic,
            bufferline.style_preset.no_bold
          }
        },

        -- Custom highlights defined — if not defined, we let `themeable = true` handle that automatically.
        -- If you switch themes, bufferline will follow along.
        highlights = {
          buffer_selected = {
            bold = true,
          },
        }
      })

      -- Keymaps for navigation and buffer actions
      vim.keymap.set("n", "<S-l>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
      vim.keymap.set("n", "<S-h>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
      vim.keymap.set("n", "<leader>bl", "<cmd>BufferLineMoveNext<CR>", { desc = "Move buffer right" })
      vim.keymap.set("n", "<leader>bh", "<cmd>BufferLineMovePrev<CR>", { desc = "Move buffer left" })
      vim.keymap.set("n", "<leader>bc", "<cmd>BufferLinePick<CR>", { desc = "Choose (Pick) buffer" })
      vim.keymap.set("n", "<leader>bp", "<cmd>BufferLineTogglePin<CR>", { desc = "Toggle buffer pin" })

      -- Smart close current buffer
      vim.keymap.set("n", "<leader>bdc", function()
        smart_buf_delete(vim.api.nvim_get_current_buf())
      end, { desc = "Smart current buffer delete" })

      -- Close all other buffer except current
      vim.keymap.set("n", "<leader>bdo", "<cmd>BufferLineCloseOthers<CR>",
        { desc = "Close all other buffers" })

      -- Close all non-pinned buffers and focus smartly
      vim.keymap.set("n", "<leader>bdp", function()
        -- Close all unpinned buffers
        vim.cmd("BufferLineGroupClose ungrouped")

        local current = vim.api.nvim_get_current_buf()
        local alt = vim.fn.bufnr("#")

        -- safe require of bufferline.state
        local ok, state = pcall(require, "bufferline.state")
        if not ok or type(state) ~= "table" or type(state.buffers) ~= "table" then
          state = nil
        end

        -- helper: check if buffer is valid & pinned
        local function is_pinned(bufnr)
          if type(bufnr) ~= "number" or bufnr < 1 or not vim.api.nvim_buf_is_valid(bufnr) then
            return false
          end

          -- 1) Prefer bufferline.state if available
          if state then
            for _, b in ipairs(state.buffers) do
              if b and b.id == bufnr and b.pinned then
                return true
              end
            end
          end

          -- 2) Fallback: check common buffer-local markers some setups set
          local b_v = vim.b[bufnr]
          if type(b_v) == "table" then
            if b_v.pinned == true or b_v.bufferline_pinned == true or b_v.bufferline_pin == true then
              return true
            end
          end

          return false
        end

        -- 1) Try alternate buffer if it exists and is pinned
        if is_pinned(alt) and vim.api.nvim_buf_is_valid(alt) then
          vim.api.nvim_set_current_buf(alt)
          return
        end

        -- 2) Else fallback to the first pinned buffer known to bufferline.state
        if state then
          for _, b in ipairs(state.buffers) do
            if b and b.pinned and vim.api.nvim_buf_is_valid(b.id) then
              vim.api.nvim_set_current_buf(b.id)
              return
            end
          end
        end

        -- 3) If no pinned buffers found, pick a sensible listed buffer (avoid NvimTree)
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          if vim.api.nvim_buf_is_valid(buf)
              and vim.bo[buf].buflisted
              and vim.api.nvim_buf_get_name(buf) ~= ""
              and vim.bo[buf].filetype ~= "NvimTree" then
            vim.api.nvim_set_current_buf(buf)
            return
          end
        end

        -- 4) If everything was wiped and current is invalid, create a scratch buffer
        if not vim.api.nvim_buf_is_valid(current) then
          vim.cmd("enew")
        end
      end, { desc = "Close non-pinned buffers" })

      -- Close all visible buffers to the right of the current buffer
      vim.keymap.set("n", "<leader>bdl", "<cmd>BufferLineCloseRight<CR>",
        { desc = "Close all visible buffers to the right of the current buffer" })

      -- Close all visible buffers to the left of the current buffer
      vim.keymap.set("n", "<leader>bdh", "<cmd>BufferLineCloseLeft<CR>",
        { desc = "Close all visible buffers to the left of the current buffer" })
    end
  },
}
