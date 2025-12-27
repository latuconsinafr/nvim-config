return {
  "tpope/vim-dadbod",
  dependencies = {
    {
      "kristijanhusak/vim-dadbod-ui",
      cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection" },
    },
    {
      "kristijanhusak/vim-dadbod-completion",
      ft = { "sql", "mysql", "plsql" },
    },
  },
  cmd = { "DB", "DBUI", "DBUIToggle", "DBUIAddConnection" },
  keys = {
    { "<leader>dt", desc = "Toggle DB UI" },
  },
  init = function()
    -- Prevent .psqlrc from interfering with metadata queries
    vim.env.PSQLRC = "/dev/null"

    -- UI behaviour
    -- NOTE: There's a weird behaviour for saved query results that keep displayed on top of the 
    -- current buffer if it closed previously
    vim.g.db_ui_use_nerd_fonts = 1
    vim.g.db_ui_show_database_icon = 1
    vim.g.db_ui_save_location = vim.fn.stdpath("data") .. "/dadbod_ui"
    vim.g.db_ui_execute_on_save = 0
    vim.g.db_ui_auto_execute_table_helpers = 1
    vim.g.db_ui_use_nvim_notify = 0

    -- Dadbod results buffers
    local dbout_group = vim.api.nvim_create_augroup("DadbodDboutUI", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      group = dbout_group,
      pattern = "dbout",
      callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.signcolumn = "no"
        vim.opt_local.wrap = false
        vim.opt_local.cursorline = true
      end,
    })

    -- Rose Pine theme integration
    local function set_dadbod_highlights()
      local rose_pine = {
        surface = "#1f1d2e",
        overlay = "#26233a",
        muted = "#6e6a86",
        text = "#e0def4",
        love = "#eb6f92",
        gold = "#f6c177",
        foam = "#9ccfd8",
      }

      -- DBUI notifications (these are what you're seeing)
      vim.api.nvim_set_hl(0, "NotificationInfo", {
        fg = rose_pine.foam,
        bg = rose_pine.surface
      })
      vim.api.nvim_set_hl(0, "NotificationWarning", {
        fg = rose_pine.gold,
        bg = rose_pine.surface
      })
      vim.api.nvim_set_hl(0, "NotificationError", {
        fg = rose_pine.love,
        bg = rose_pine.surface
      })

      -- DBUI UI elements
      vim.api.nvim_set_hl(0, "dbui_tables", { fg = rose_pine.text })
      vim.api.nvim_set_hl(0, "dbui_schemas", { fg = rose_pine.foam })
      vim.api.nvim_set_hl(0, "dbui_connection", { fg = rose_pine.gold })

      -- Noice popups (if using Noice for other things)
      vim.api.nvim_set_hl(0, "NoicePopup", { bg = rose_pine.surface })
      vim.api.nvim_set_hl(0, "NoicePopupBorder", {
        fg = rose_pine.muted,
        bg = rose_pine.surface
      })
      vim.api.nvim_set_hl(0, "NoiceCmdlinePopup", { bg = rose_pine.surface })
      vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder", {
        fg = rose_pine.muted,
        bg = rose_pine.surface
      })
    end

    set_dadbod_highlights()
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = set_dadbod_highlights,
    })
  end,
  config = function()
    local original_width = 40
    local step = 10

    -- Sidebar helper
    local function is_sidebar_open(ft)
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        if vim.bo[buf].filetype == ft then
          return true, win
        end
      end
      return false, nil
    end

    -- Get DBUI window
    local function get_dbui_window()
      local is_open, win = is_sidebar_open("dbui")
      return is_open and win or nil
    end

    -- Ensure ONLY DBUI is open
    local function ensure_exclusive_dbui()
      if is_sidebar_open("NvimTree") then
        vim.cmd("NvimTreeClose")
      end
      if not is_sidebar_open("dbui") then
        vim.cmd("DBUI")
      end
    end

    -- Grow DBUI
    local function grow_dbui()
      ensure_exclusive_dbui()
      local win = get_dbui_window()
      if win then
        local cur_width = vim.api.nvim_win_get_width(win)
        local new_width = math.min(vim.o.columns, cur_width + step)
        vim.api.nvim_win_set_width(win, new_width)
      end
    end

    -- Shrink DBUI
    local function shrink_dbui()
      ensure_exclusive_dbui()
      local win = get_dbui_window()
      if win then
        local cur_width = vim.api.nvim_win_get_width(win)
        local new_width = math.max(original_width, cur_width - step)
        vim.api.nvim_win_set_width(win, new_width)
      end
    end

    -- Toggle DBUI (exclusive)
    vim.keymap.set("n", "<leader>dt", function()
      if is_sidebar_open("NvimTree") then
        vim.cmd("NvimTreeClose")
      end
      if is_sidebar_open("dbui") then
        vim.cmd("DBUIClose")
      else
        vim.cmd("DBUI")
      end
    end, { desc = "Toggle DB UI (exclusive)" })

    -- Execute query
    vim.keymap.set("n", "<leader>dq", "<Plug>(DBUI_ExecuteQuery)", { desc = "Execute SQL" })
    vim.keymap.set("v", "<leader>dq", "<Plug>(DBUI_ExecuteQuery)", { desc = "Execute SQL (selection)" })

    -- Grow/shrink DBUI
    vim.keymap.set("n", "<leader>d]", grow_dbui, { desc = "Grow DBUI by 10 cols" })
    vim.keymap.set("n", "<leader>d[", shrink_dbui, { desc = "Shrink DBUI by 10 cols (min 40)" })
  end,
}
