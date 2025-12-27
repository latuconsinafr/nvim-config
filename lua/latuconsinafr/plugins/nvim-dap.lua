---@diagnostic disable: undefined-field
return {
  {
    "mfussenegger/nvim-dap", -- Debug Adapter Protocol client for Neovim
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason.nvim",         -- Required for mason nvim dap
      "rcarriga/nvim-dap-ui",            -- UI for nvim-dap
      "nvim-neotest/nvim-nio",           -- Required async IO library for dap-ui
      "theHamsta/nvim-dap-virtual-text", -- Show variable values inline during debugging
      "jay-babu/mason-nvim-dap.nvim",    -- Bridge between mason and nvim-dap
    },
    keys = {
      -- Breakpoint controls
      { "<leader>db", function() require("dap").toggle_breakpoint() end,                                    desc = "Toggle Breakpoint" },
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "Conditional Breakpoint" },

      -- Execution controls
      { "<leader>dc", function() require("dap").continue() end,                                             desc = "Start / Continue Debug" },
      { "<leader>dC", function() require("dap").run_to_cursor() end,                                        desc = "Run to Cursor" },
      { "<leader>di", function() require("dap").step_into() end,                                            desc = "Step Into" },
      { "<leader>do", function() require("dap").step_over() end,                                            desc = "Step Over" },
      { "<leader>dO", function() require("dap").step_out() end,                                             desc = "Step Out" },
      { "<leader>dp", function() require("dap").pause() end,                                                desc = "Pause" },
      { "<leader>dt", function() require("dap").terminate() end,                                            desc = "Terminate" },

      -- Session and UI controls
      { "<leader>dr", function() require("dap").repl.toggle() end,                                          desc = "Toggle REPL" },
      { "<leader>ds", function() require("dap").session() end,                                              desc = "Session" },
      { "<leader>du", function() require("dapui").toggle() end,                                             desc = "Toggle DAP UI" },
      { "<leader>de", function() require("dapui").eval() end,                                               desc = "Eval",                  mode = { "n", "v" } },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- Mason DAP setup: auto-install debug adapters
      require("mason-nvim-dap").setup({
        ensure_installed = { "js-debug-adapter", "codelldb" }, -- js-debug-adapter for JS/TS, codelldb for Rust/C/C++
        automatic_installation = true,                         -- Auto-install adapters when needed
        handlers = {
          function(config)
            -- All sources with no handler get passed here

            -- Keep original functionality
            require('mason-nvim-dap').default_setup(config)
          end,
        },
      })

      -- JavaScript/TypeScript adapter
      dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "node",
          args = {
            vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
            "${port}",
          },
        },
      }

      -- Virtual text: show variable values inline in the code
      require("nvim-dap-virtual-text").setup({
        commented = true, -- Prefix virtual text with comment syntax
      })

      -- DAP UI setup: configure debugging interface layout
      dapui.setup({
        icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
        render = {
          indent = 1,
          max_type_length = 20, -- keeps type readable
          max_value_lines = 1, -- prevents vertical spam
        },
        layouts = {
          {
            -- Left panel: debugging context
            elements = {
              { id = "scopes",      size = 0.25 }, -- Local/global variables
              { id = "breakpoints", size = 0.25 }, -- List of breakpoints
              { id = "stacks",      size = 0.25 }, -- Call stack
              { id = "watches",     size = 0.25 }, -- Watch expressions
            },
            position = "left",
            size = 40,
          },
          {
            -- Bottom panel: output and interaction
            elements = {
              { id = "repl",    size = 0.5 }, -- Debug REPL
              { id = "console", size = 0.5 }, -- Debug console output
            },
            position = "bottom",
            size = 10,
          },
        },
        floating = {
          max_height = 0.25, -- 25% of screen height
          max_width = 0.40,  -- 40% of screen width
          border = "rounded",
        }
      })

      -- Custom signs for breakpoints and debug state
      vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError" })
      vim.fn.sign_define("DapBreakpointCondition", { text = "◐", texthl = "DiagnosticWarn" })
      vim.fn.sign_define("DapBreakpointRejected", { text = "○", texthl = "DiagnosticError" })
      vim.fn.sign_define("DapLogPoint", { text = "◆", texthl = "DiagnosticInfo" })
      vim.fn.sign_define("DapStopped", { text = "→", texthl = "DiagnosticOk", linehl = "DapStoppedLine" })

      -- Reset sidebar width after DAP UI closes
      local function reset_sidebar_width()
        vim.defer_fn(function()
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            local buf = vim.api.nvim_win_get_buf(win)
            local ft = vim.bo[buf].filetype
            if ft == "NvimTree" then
              vim.api.nvim_win_set_width(win, 40)
            elseif ft == "dbui" then
              vim.api.nvim_win_set_width(win, 40)
            end
          end
        end, 100)
      end

      -- Auto open/close DAP UI when debugging starts/ends
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
        reset_sidebar_width()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
        reset_sidebar_width()
      end

      -- Debug configurations for JavaScript/TypeScript filetypes
      for _, lang in ipairs({
        "javascript",
        "typescript",
        "javascriptreact",
        "typescriptreact",
      }) do
        dap.configurations[lang] = {
          -- Attach node js
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach Node js (9229)",
            port = 9229,
            cwd = "${workspaceFolder}",
            sourceMaps = true,
            restart = true,
            skipFiles = { "<node_internals>/**", "node_modules/**" },
            resolveSourceMapLocations = {
              "${workspaceFolder}/**",
              "!**/node_modules/**"
            },
          },
          -- Launch current file
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            cwd = "${workspaceFolder}",
            sourceMaps = true,
            protocol = "inspector",
            console = "integratedTerminal",
          },
          -- Attach to process
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach to process",
            processId = require("dap.utils").pick_process,
            cwd = "${workspaceFolder}",
            sourceMaps = true,
          },
        }
      end

      -- Debug configurations for Rust
      dap.configurations.rust = {
        {
          name = "Launch",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input(
              "Path to executable: ",
              vim.fn.getcwd() .. "/target/debug/",
              "file"
            )
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
      }

      -- DAP UI resize helpers
      local resize_step = 10

      local function get_dapui_left_window()
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          local buf = vim.api.nvim_win_get_buf(win)
          local ft = vim.bo[buf].filetype
          if ft:match("^dapui_scopes") or ft:match("^dapui_breakpoints")
              or ft:match("^dapui_stacks") or ft:match("^dapui_watches") then
            return win
          end
        end
        return nil
      end

      local function get_dapui_bottom_window()
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          local buf = vim.api.nvim_win_get_buf(win)
          local ft = vim.bo[buf].filetype
          if ft == "dapui_console" or ft == "dap-repl" then
            return win
          end
        end
        return nil
      end

      local function grow_dap_left()
        local win = get_dapui_left_window()
        if win then
          local cur = vim.api.nvim_win_get_width(win)
          vim.api.nvim_win_set_width(win, math.min(vim.o.columns - 20, cur + resize_step))
        end
      end

      local function shrink_dap_left()
        local win = get_dapui_left_window()
        if win then
          local cur = vim.api.nvim_win_get_width(win)
          vim.api.nvim_win_set_width(win, math.max(30, cur - resize_step))
        end
      end

      local function grow_dap_bottom()
        local win = get_dapui_bottom_window()
        if win then
          local cur = vim.api.nvim_win_get_height(win)
          vim.api.nvim_win_set_height(win, math.min(vim.o.lines - 10, cur + resize_step))
        end
      end

      local function shrink_dap_bottom()
        local win = get_dapui_bottom_window()
        if win then
          local cur = vim.api.nvim_win_get_height(win)
          vim.api.nvim_win_set_height(win, math.max(5, cur - resize_step))
        end
      end

      -- Keymaps for resizing DAP UI
      vim.keymap.set("n", "<leader>d]", grow_dap_left, { desc = "Grow DAP left panel" })
      vim.keymap.set("n", "<leader>d[", shrink_dap_left, { desc = "Shrink DAP left panel" })
      vim.keymap.set("n", "<leader>d}", grow_dap_bottom, { desc = "Grow DAP bottom panel" })
      vim.keymap.set("n", "<leader>d{", shrink_dap_bottom, { desc = "Shrink DAP bottom panel" })
    end,
  },
}
