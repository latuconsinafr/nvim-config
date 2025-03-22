-- Load Mason and set up LSP servers
local mason = require('mason')
local mason_lspconfig = require('mason-lspconfig')
local lspconfig = require('lspconfig')

mason.setup()
mason_lspconfig.setup {
  ensure_installed = {
    'lua_ls',       -- lua
    'eslint',       -- eslint
    'ts_ls',        -- typescript
    'rust_analyzer' -- rust
  }
}

-- Key mappings for LSP functions
local function on_attach(client, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }
  -- Mapping for LSP features
  vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.keymap.set('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)

  -- Custom format function that handles TypeScript/JavaScript differently
  vim.keymap.set('n', '<leader>f', function()
    local filetype = vim.bo.filetype

    -- For TypeScript/JavaScript files, use ESLint fix command
    if filetype == "typescript" or filetype == "javascript" or
        filetype == "typescriptreact" or filetype == "javascriptreact" then
      vim.cmd("EslintFixAll")
    else
      -- For other filetypes, use the standard format
      vim.lsp.buf.format()
    end
  end, opts)

  vim.keymap.set('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.keymap.set('n', '<leader>sh', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)

  -- Diagnostic
  vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  vim.keymap.set('n', 'd]', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  vim.keymap.set('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)

  -- Quickfix navigation for diagnostics
  vim.keymap.set('n', '<leader>q', function()
    vim.diagnostic.setloclist({ open = false })
    local current_window = vim.api.nvim_get_current_win()
    vim.cmd("lwindow")
    vim.api.nvim_set_current_win(current_window)
  end, opts)
end

-- Setup all LSP servers
mason_lspconfig.setup_handlers({
  function(server_name)
    local config = {
      on_attach = on_attach,
    }

    -- Special server-specific settings
    if server_name == "lua_ls" then
      config.settings = {
        Lua = {
          diagnostics = {
            globals = { 'vim' }
          },
        },
      }
    end

    lspconfig[server_name].setup(config)
  end
})
