return {
  "nvim-tree/nvim-tree.lua", -- The main nvim-tree plugin repo
  version = "*",             -- Use the latest stable version
  lazy = false,              -- Load this plugin eagerly on startup (not lazily)

  -- Dependency on nvim-web-devicons for file/folder icons
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },

  -- Load the plugin when these commands are called (helps lazy loading)
  cmd = { "NvimTreeToggle", "NvimTreeRefresh", "NvimTreeFindFile" },

  -- Key mappings for nvim-tree functionality with descriptions
  keys = {
    { "<leader>tt", "<cmd>NvimTreeToggle<cr>",   desc = "Toggle Nvim Tree" },       -- Toggle file explorer
    { "<leader>tr", "<cmd>NvimTreeRefresh<cr>",  desc = "Refresh Nvim Tree" },      -- Refresh tree contents
    { "<leader>tf", "<cmd>NvimTreeFindFile<cr>", desc = "Find File in Nvim Tree" }, -- Focus on current file
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
  end,
}
