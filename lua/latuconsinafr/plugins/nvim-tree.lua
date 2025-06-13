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
        width = 30, -- Set the width of the nvim-tree sidebar
      },

      renderer = {
        group_empty = true, -- Group empty directories together

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

    -- Set keymaps explicitly (eagerly)
    vim.keymap.set("n", "<leader>tt", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle Nvim Tree" })
    vim.keymap.set("n", "<leader>tr", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh Nvim Tree" })
    vim.keymap.set("n", "<leader>tf", "<cmd>NvimTreeFindFile<CR>", { desc = "Find File in Nvim Tree" })
  end,
}
