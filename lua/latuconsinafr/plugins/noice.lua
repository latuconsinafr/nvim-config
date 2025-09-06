return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    -- add any options here
  },
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper module="..." entries
    "MunifTanjim/nui.nvim",
    -- OPTIONAL:
    --   nvim-notify is only needed, if you want to use the notification view.
    --   If not available, we use mini as the fallback
    "rcarriga/nvim-notify",
  },
  config = function()
    require("noice").setup({
      cmdline = {
        enabled = true,
        view = "cmdline",
      },
      messages = {
        enabled = true,
        view = "notify"
      },
      popupmenu = {
        enabled = true,
        view = "nui",
        kind_icons = {}
      },
      notify = {
        enabled = true,
        view = "notify"
      },
      lsp = {
        progress = {
          enabled = true,
          view = "mini"
        },
        override = {
          -- override the default lsp markdown formatter with Noice
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          -- override the lsp markdown formatter with Noice
          ["vim.lsp.util.stylize_markdown"] = true,
          -- override cmp documentation with Noice (needs the other options to work)
          ["cmp.entry.get_documentation"] = true,
        },
        hover = {
          enabled = true,
          silent = false, -- set to true to not show a message if hover is not available
          view = nil,     -- when nil, use defaults from documentation
        },
        signature = {
          enabled = true,
          auto_open = {
            enabled = true,
            trigger = true, -- Automatically show signature help when typing a trigger character from the LSP
            luasnip = true, -- Will open signature help when jumping to Luasnip insert nodes
            throttle = 50,  -- Debounce lsp signature help request by 50ms
          },
          view = nil,       -- when nil, use defaults from documentation
        },
        message = {
          -- Messages shown by lsp servers
          enabled = true,
          view = "notify",
          opts = {},
        },
        -- defaults for hover and signature help
        documentation = {
          view = "hover",
          opts = {
            lang = "markdown",
            replace = true,
            render = "plain",
            format = { "{message}" },
            win_options = { concealcursor = "n", conceallevel = 3 },
          },
        },
      },
      markdown = {
        hover = {
          ["|(%S-)|"] = vim.cmd.help,                       -- vim help links
          ["%[.-%]%((%S-)%)"] = require("noice.util").open, -- markdown links
        },
        highlights = {
          ["|%S-|"] = "@text.reference",
          ["@%S+"] = "@parameter",
          ["^%s*(Parameters:)"] = "@text.title",
          ["^%s*(Return:)"] = "@text.title",
          ["^%s*(See also:)"] = "@text.title",
          ["{%S-}"] = "@parameter",
        },
      },
      -- Custom views
      views = {
        code_action_popup = {
          backend = "popup",
          relative = "editor",
          position = {
            row = -2,
            col = 2,
          },
          size = {
            width = "98%",
            height = "auto",
          },
          border = {
            style = "rounded",
            padding = { 0, 1 },
            text = {
              top = " Confirm ",
              top_align = "center",
            },
          },
          win_options = {
            winhighlight = "Normal:NormalFloat,FloatBorder:NoiceCmdlinePopupBorder,FloatTitle:NoiceCmdlinePopupBorder",
          },
          zindex = 60,
        },
      },
      -- Route specified actions to specified views
      routes = {
        -- Code action
        {
          filter = {
            event = "msg_show",
            kind = "confirm",
            find = "Code actions",
          },
          view = "code_action_popup",
        },
      },
      presets = {
        bottom_search = false,        -- use a classic bottom cmdline for search
        command_palette = false,      -- disable this to get back the cmdline area
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = true,            -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true,        -- add a border to hover docs and signature help
      },
    })

    -- Add noice lsp keymaps
    vim.keymap.set({ "n", "i", "s" }, "<C-f>", function()
      if not require("noice.lsp").scroll(4) then
        return "<C-f>"
      end
    end, { silent = true, expr = true, desc = "Noice scroll forward" })

    vim.keymap.set({ "n", "i", "s" }, "<C-b>", function()
      if not require("noice.lsp").scroll(-4) then
        return "<C-b>"
      end
    end, { silent = true, expr = true, desc = "Noice scroll backward" })
  end
}
