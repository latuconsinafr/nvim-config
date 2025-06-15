return {
  -- Fuzzy finder plugin with rich preview and Lua-first config
  "ibhagwan/fzf-lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons"                                                          -- Optional icons for better visuals
  },
  cmd = "FzfLua",                                                                          -- Load the plugin only when the FzfLua command is triggered
  keys = {
    { "<leader>ff",  "<cmd>FzfLua files<CR>",           desc = "Find Files" },             -- Search for files
    { "<leader>fg",  "<cmd>FzfLua live_grep<CR>",       desc = "Live Grep" },              -- Live grep in project
    { "<leader>fb",  "<cmd>FzfLua buffers<CR>",         desc = "Buffers" },                -- List open buffers
    { "<leader>fh",  "<cmd>FzfLua help_tags<CR>",       desc = "Help Tags" },              -- Search Neovim help
    { "<leader>fc",  "<cmd>FzfLua commands<CR>",        desc = "Commands" },               -- Show available commands
    { "<leader>fch", "<cmd>FzfLua command_history<CR>", desc = "Commands history" },       -- View command history
    { "<leader>fr",  "<cmd>FzfLua oldfiles<CR>",        desc = "Recent Files" },           -- Recently opened files
    { "<leader>ft",  "<cmd>FzfLua grep_cword<CR>",      desc = "Grep word under cursor" }, -- Grep for word under cursor
  },
  config = function()
    require("fzf-lua").setup({
      -- Window appearance configuration
      winopts = {
        height = 0.85,         -- 85% of the editor height
        width = 0.85,          -- 85% of the editor width
        row = 0.35,            -- Vertical position (top=0, bottom=1)
        col = 0.5,             -- Horizontal position (left=0, right=1)
        border = "rounded",    -- Rounded border style
        preview = {
          default = "bat",     -- Use `bat` (if installed) for syntax-highlighted preview
          border = "noborder", -- No border around the preview window
        },
      },

      -- File search configuration
      files = {
        prompt = "Files ❯ ", -- Custom prompt text
        cwd_prompt = true, -- Show the current working directory in the prompt
        fd_opts = "--color=never --type f --hidden --follow --exclude .git", -- fd command options
      },

      -- Grep (ripgrep) configuration
      grep = {
        prompt = "Grep ❯ ", -- Custom prompt text
        rg_opts = "--color=never --no-heading --with-filename --line-number --column --smart-case", -- rg options
      },

      -- fzf-specific options
      fzf_opts = {
        ["--layout"] = "reverse", -- Show results from bottom to top
        ["--info"]   = "inline",  -- Display info line within the results
      },

      -- Key mappings for preview scrolling (fzf native bindings)
      keymap = {
        fzf = {
          -- Scroll preview window down faster (10 lines at a time)
          ["ctrl-d"] =
          "preview-down+preview-down+preview-down+preview-down+preview-down+preview-down+preview-down+preview-down+preview-down+preview-down",
          -- Scroll preview window up faster (10 lines at a time)
          ["ctrl-u"] =
          "preview-up+preview-up+preview-up+preview-up+preview-up+preview-up+preview-up+preview-up+preview-up+preview-up",
        },
      },

      actions = {
        files = {
          -- default enter behavior: open file(s)
          ["default"] = require("fzf-lua.actions").file_edit_or_qf,
          -- ctrl-q to quickfix
          ["ctrl-q"] = function(selected)
            local qf_entries = {}
            for _, file in ipairs(selected) do
              table.insert(qf_entries, { filename = file })
            end
            vim.fn.setqflist({}, ' ', { title = 'FzfLua Selected Files', items = qf_entries })
            vim.cmd("copen")
          end
        }
      }
    })
  end,
}
