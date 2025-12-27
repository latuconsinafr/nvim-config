return {
  "nvim-tree/nvim-tree.lua", -- The main nvim-tree plugin repo
  version = "*",             -- Use the latest stable version
  lazy = false,              -- Load this plugin eagerly on startup

  -- Dependency on nvim-web-devicons for file/folder icons
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },

  -- Plugin configuration function, runs when plugin is loaded
  config = function()
    require("nvim-tree").setup {
      sort_by = "case_sensitive", -- Sort files/folders case sensitively

      view = {
        width = 40, -- Set the width of the nvim-tree sidebar
      },

      renderer = {
        group_empty = true, -- Group empty directories together

        indent_markers = {  -- Indent marker
          enable = true,
          icons = {
            corner = "└",
            edge = "│",
            item = "│",
            none = " ",
          },
        },

        icons = {
          show = {
            file = true,         -- Show file icons
            folder = true,       -- Show folder icons
            folder_arrow = true, -- Show arrow indicators for folders
            git = true,          -- Show git status icons
          },
        },
      },

      filters = {
        dotfiles = false, -- Show dotfiles (true = hide dotfiles)
        custom = {        -- Custom file/folder filters (hide these)
          "^.git$",       -- Hide .git folder
          "^.svn$",       -- Hide .svn folder
          "^.hg$",        -- Hide .hg folder
          "^CVS$",        -- Hide CVS folder
          "^.DS_Store$",  -- Hide macOS metadata file
          "^Thumbs.db$",  -- Hide Windows thumbnail cache
        },
      },

      git = {
        enable = true,  -- Enable git integration for file status
        ignore = false, -- Show files even if they are ignored by gitignore
        timeout = 500,  -- Timeout for git commands in milliseconds
      },
    }

    local api            = require("nvim-tree.api")
    local view_module    = require("nvim-tree.view")
    local original_width = 40
    local step           = 10

    -- Sidebar helper
    local function is_sidebar_open(ft)
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        if vim.bo[buf].filetype == ft then
          return true
        end
      end
      return false
    end

    -- Ensure only NvimTree is open
    local function ensure_exclusive_nvimtree()
      if is_sidebar_open("dbui") then
        vim.cmd("DBUIClose")
      end
      if not view_module.is_visible() then
        api.tree.open()
      end
    end

    -- Increase by `step`, up to vim.o.columns
    local function grow_tree()
      ensure_exclusive_nvimtree()
      local cur = view_module.View.width or original_width
      local nw  = math.min(vim.o.columns, cur + step)
      view_module.resize(nw)
    end

    -- Decrease by `step`, but never below `original_width`
    local function shrink_tree()
      ensure_exclusive_nvimtree()
      local cur = view_module.View.width or original_width
      local nw  = math.max(original_width, cur - step)
      view_module.resize(nw)
    end

    -- Set keymaps explicitly (eagerly)
    vim.keymap.set("n", "<leader>Tt", function()
      -- Close DBUI first
      if is_sidebar_open("dbui") then
        vim.cmd("DBUIClose")
      end

      -- Toggle NvimTree
      vim.cmd("NvimTreeToggle")
    end, { desc = "Toggle NvimTree (exclusive)" })

    vim.keymap.set("n", "<leader>Tr", function()
      ensure_exclusive_nvimtree()
      vim.cmd("NvimTreeRefresh")
    end, { desc = "Refresh Nvim Tree" })

    vim.keymap.set("n", "<leader>Tf", function()
      ensure_exclusive_nvimtree()
      vim.cmd("NvimTreeFindFile")
    end, { desc = "Find File in Nvim Tree" })

    vim.keymap.set("n", "<leader>T]", grow_tree, { desc = "Grow Nvim‑Tree by 10 cols" })
    vim.keymap.set("n", "<leader>T[", shrink_tree, { desc = "Shrink Nvim‑Tree by 10 cols (min 30)" })

    -- Define the highlight group for indent marker AFTER setup,
    vim.api.nvim_set_hl(0, "NvimTreeIndentMarker", { fg = "#6e6a86" }) -- a muted, slightly purplish gray from the Rose Pine palette.
  end,
}
