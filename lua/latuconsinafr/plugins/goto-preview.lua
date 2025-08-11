return {
  "rmagatti/goto-preview",  -- Plugin for previewing definitions, implementations, etc., in a floating window
  dependencies = {
    "rmagatti/logger.nvim", -- Optional dependency used internally by goto-preview for logging
  },
  event = "BufEnter",       -- Lazy-load the plugin when entering a buffer (efficient startup)
  config = function()
    require("goto-preview").setup({
      default_mappings = true, -- Enables default keymaps:
      -- gpd → Preview definition
      -- gpt → Preview type definition
      -- gpi → Preview implementation
      -- gpD → Close all previews

      -- Add post_open_hook to enable float-to-split conversion
      post_open_hook = function(buffer, _)
        local opts = { noremap = true, silent = true, buffer = buffer }

        -- Convert to vertical split (float content to the RIGHT)
        vim.keymap.set('n', 'gpv', function()
          local float_buf = vim.api.nvim_get_current_buf()
          local cursor_pos = vim.api.nvim_win_get_cursor(0)
          local buf_name = vim.api.nvim_buf_get_name(float_buf)

          -- Close the float first
          require('goto-preview').close_all_win()

          -- Now we're back in original buffer, create split to the right
          vim.cmd('vsplit')
          vim.cmd('wincmd l') -- Move to the right split

          -- Open the file properly instead of just setting buffer
          if buf_name and buf_name ~= "" then
            vim.cmd('edit ' .. vim.fn.fnameescape(buf_name))
            vim.api.nvim_win_set_cursor(0, cursor_pos)
          else
            -- Fallback if no filename - using new API
            vim.bo[float_buf].buflisted = true
            vim.api.nvim_win_set_buf(0, float_buf)
            vim.api.nvim_win_set_cursor(0, cursor_pos)
          end
        end, opts)

        -- Same for horizontal split
        vim.keymap.set('n', 'gps', function()
          local float_buf = vim.api.nvim_get_current_buf()
          local cursor_pos = vim.api.nvim_win_get_cursor(0)
          local buf_name = vim.api.nvim_buf_get_name(float_buf)

          require('goto-preview').close_all_win()
          vim.cmd('split')
          vim.cmd('wincmd j')

          if buf_name and buf_name ~= "" then
            vim.cmd('edit ' .. vim.fn.fnameescape(buf_name))
            vim.api.nvim_win_set_cursor(0, cursor_pos)
          else
            vim.bo[float_buf].buflisted = true
            vim.api.nvim_win_set_buf(0, float_buf)
            vim.api.nvim_win_set_cursor(0, cursor_pos)
          end
        end, opts)

        vim.keymap.set('n', 'q', function()
          require('goto-preview').close_all_win()
        end, opts)
      end,
    })
  end,
}
