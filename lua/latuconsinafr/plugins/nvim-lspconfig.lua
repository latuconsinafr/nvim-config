return {
  -- Autocompletion via nvim-cmp
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
      "f3fora/cmp-spell",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args) luasnip.lsp_expand(args.body) end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "spell" },
        }, {
          { name = "buffer" },
          { name = "path" },
        }),
        formatting = {
          format = function(entry, vim_item)
            local icons = {
              Text = "󰉿",
              Method = "󰆧",
              Function = "󰊕",
              Constructor = "󰡱",
              Field = "󰇽",
              Variable = "󰂡",
              Class = "󰠱",
              Interface = "󰜰",
              Module = "󰏗",
              Property = "󰜢",
              Unit = "󰑭",
              Value = "󰎠",
              Enum = "󰕘",
              Keyword = "󰌋",
              Snippet = "",
              Color = "󰏘",
              File = "󰈙",
              Reference = "󰈇",
              Folder = "󰉋",
              EnumMember = "󰘀",
              Constant = "󰏿",
              Struct = "󰙅",
              Event = "󱐋",
              Operator = "󰆕",
              TypeParameter = "󰅲",
            }
            vim_item.kind = (icons[vim_item.kind] or "") .. " " .. vim_item.kind
            vim_item.menu = ({
              nvim_lsp = "[LSP]",
              luasnip = "[Snippet]",
              buffer = "[Buffer]",
              path = "[Path]",
            })[entry.source.name]
            return vim_item
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
      })

      -- Set configuration for specific filetype
      cmp.setup.filetype("gitcommit", { sources = { { name = "buffer" } } })

      -- Use buffer source for `/` and `?`
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = { { name = "buffer" } },
      })

      -- Use cmdline & path source for `:`
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources(
          { { name = "path" } },
          { { name = "cmdline" } }
        ),
      })
    end,
  },

  -- Mason: Package manager for LSP servers, DAP servers, linters, and formatters
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    opts = {
      ensure_installed = { "lua-language-server" },
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
    end,
  },

  -- Mason LSPConfig: Bridge between mason and lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      local lspconfig = require("lspconfig")
      local mason_lspconfig = require("mason-lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- LSP attach function
      local on_attach = function(_, bufnr)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration", buffer = bufnr })
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition", buffer = bufnr })
        vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation", buffer = bufnr })
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation", buffer = bufnr })
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature help", buffer = bufnr })

        vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder,
          { desc = "Add workspace folder", buffer = bufnr })
        vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder,
          { desc = "Remove workspace folder", buffer = bufnr })
        vim.keymap.set("n", "<leader>wl", function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, { desc = "List workspace folders", buffer = bufnr })

        vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, { desc = "Go to type definition", buffer = bufnr })
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol", buffer = bufnr })
        vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action", buffer = bufnr })
        vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Find references", buffer = bufnr })

        vim.keymap.set("n", "<leader>f", function()
          vim.lsp.buf.format({ async = true })
        end, { desc = "Format buffer", buffer = bufnr })

        -- Lsp picker capability with fzf lua
        local ok, fzf = pcall(require, "fzf-lua")

        if not ok then return end

        vim.keymap.set("n", "<leader>ls", fzf.lsp_document_symbols, { desc = "Document Symbols", buffer = bufnr })
        vim.keymap.set("n", "<leader>lS", fzf.lsp_workspace_symbols, { desc = "Workspace Symbols", buffer = bufnr })
        vim.keymap.set("n", "<leader>ld", fzf.lsp_definitions, { desc = "Definitions", buffer = bufnr })
        vim.keymap.set("n", "<leader>lD", fzf.lsp_declarations, { desc = "Definitions", buffer = bufnr })
        vim.keymap.set("n", "<leader>lr", fzf.lsp_references, { desc = "References", buffer = bufnr })
        vim.keymap.set("n", "<leader>li", fzf.lsp_implementations, { desc = "Implementations", buffer = bufnr })
        vim.keymap.set("n", "<leader>lT", fzf.lsp_typedefs, { desc = "Type Definitions", buffer = bufnr })
        vim.keymap.set("n", "<leader>lI", fzf.lsp_incoming_calls, { desc = "Incoming Calls", buffer = bufnr })
        vim.keymap.set("n", "<leader>lO", fzf.lsp_outgoing_calls, { desc = "Outgoing Calls", buffer = bufnr })
        vim.keymap.set("n", "<leader>ldd", fzf.diagnostics_document, { desc = "Diagnostics", buffer = bufnr })
        vim.keymap.set("n", "<leader>ldw", fzf.diagnostics_workspace, { desc = "Diagnostics", buffer = bufnr })
        vim.keymap.set("n", "<leader>lc", fzf.lsp_code_actions, { desc = "Code Actions", buffer = bufnr })
      end

      -- Explicit setup for `lua_ls`
      lspconfig.lua_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            runtime = { version = "LuaJIT" },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = { enable = false },
          },
        },
      })

      -- Explicit setup for `ts_ls`
      lspconfig.ts_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          typescript = {
            inlayHints = {
              -- Show parameter names inline: func(paramName: value)
              includeInlayParameterNameHints = 'all',
              -- Don't show param names when argument matches parameter name
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              -- Show type hints for function parameters
              includeInlayFunctionParameterTypeHints = true,
              -- Show type hints for variables: let x: string = "hello"
              includeInlayVariableTypeHints = true,
              -- Show type hints for object properties
              includeInlayPropertyDeclarationTypeHints = true,
              -- Show return type hints for functions
              includeInlayFunctionLikeReturnTypeHints = true,
              -- Show values for enum members
              includeInlayEnumMemberValueHints = true,
            }
          },
          javascript = {
            inlayHints = {
              -- Same inlay hints for JavaScript files
              includeInlayParameterNameHints = 'all',
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            }
          }
        }
      })

      -- Explicit setup for `eslint`
      lspconfig.eslint.setup({
        on_attach = function(client, bufnr)
          on_attach(client, bufnr)

          -- Auto-fix ESLint issues on save (formatting + linting fixes)
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            command = "EslintFixAll",
          })
        end,
        capabilities = capabilities,
        settings = {
          codeAction = {
            -- Enable "disable rule" comments with separate line placement
            disableRuleComment = {
              enable = true,
              location = "separateLine" -- Put // eslint-disable-next-line on separate line
            },
            -- Show ESLint rule documentation in code actions
            showDocumentation = {
              enable = true
            }
          },
          -- Don't auto-fix on save via LSP (we handle this with autocmd above)
          codeActionOnSave = {
            enable = false,
            mode = "all"
          },
          experimental = {
            useFlatConfig = false       -- Use traditional .eslintrc config format
          },
          format = true,                -- Enable ESLint formatting capabilities
          nodePath = "",                -- Auto-detect Node.js path
          onIgnoredFiles = "off",       -- Don't show warnings for ignored files
          packageManager = "npm",       -- Default package manager
          problems = {
            shortenToSingleLine = false -- Show full problem descriptions
          },
          quiet = false,                -- Show all ESLint messages (not just errors)
          rulesCustomizations = {},     -- Custom rule configurations
          run = "onType",               -- Run ESLint as you type
          useESLintClass = false,       -- Use ESLint CLI instead of ESLint class
          validate = "on",              -- Always validate files
          workingDirectory = {
            mode = "location"           -- Use file location as working directory
          }
        }
      })

      -- Servers to skip due to explicit setup
      local servers_to_skip = {
        "lua_ls",
        "ts_ls",
        "eslint"
      }

      -- Configure mason-lspconfig auto-installs and sets up all the rest
      mason_lspconfig.setup({
        ensure_installed = { "lua_ls" },
        automatic_enable = true,
        automatic_installation = true,
        handlers = {
          -- Default handler for *other* servers
          function(server_name)
            -- lua_ls is already handled
            if vim.tbl_contains(servers_to_skip, server_name) then return end

            lspconfig[server_name].setup {
              on_attach = on_attach,
              capabilities = capabilities,
            }
          end,
        },
      })
    end,
  },

  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      vim.diagnostic.config({
        virtual_text = { prefix = "●" },
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = { border = "rounded", source = true, header = "", prefix = "" },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "󰅚",
            [vim.diagnostic.severity.WARN]  = "󰀪",
            [vim.diagnostic.severity.HINT]  = "󰌶",
            [vim.diagnostic.severity.INFO]  = "󰋽",
          },
          numhl = {
            [vim.diagnostic.severity.ERROR] = "DiagnosticError",
            [vim.diagnostic.severity.WARN]  = "DiagnosticWarn",
            [vim.diagnostic.severity.HINT]  = "DiagnosticHint",
            [vim.diagnostic.severity.INFO]  = "DiagnosticInfo",
          },
        },
      })

      -- Global mappings
      vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
      vim.keymap.set("n", "[d", function()
        vim.diagnostic.jump({ count = -1, float = true })
      end)
      vim.keymap.set("n", "]d", function()
        vim.diagnostic.jump({ count = 1, float = true })
      end)
      vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)
    end,
  },
}
