-- Load Mason and set up LSP servers
local mason = require('mason')
local mason_lspconfig = require('mason-lspconfig')

-- Load the LSP
local lspconfig = require('lspconfig')

mason.setup()
mason_lspconfig.setup {
  -- List default preferred LSP servers here
  ensure_installed = {
    'lua_ls', -- lua
    'eslint', -- eslint
    'ts_ls', -- typescript
    'rust_analyzer' -- rust
  }
}

-- Key mappings for LSP functions
local function on_attach(client, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }

  -- Mapping for LSP features
  -- Buffer
  vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)             -- Go to definition
  vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)            -- Go to declaration
  vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)             -- Find references
  vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)         -- Go to implementation
  vim.keymap.set('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)        -- Go to type definition
  vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)                   -- Hover documentation
  vim.keymap.set('n', '<leader>f', '<cmd> lua vim.lsp.buf.format()<CR>', opts)         -- Format document
  vim.keymap.set('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)         -- Rename symbol
  vim.keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)    -- Code actions
  vim.keymap.set('n', '<leader>sh', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts) -- Signature help

  -- Diagnostic
  vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)         -- Go to previous diagnostic
  vim.keymap.set('n', 'd]', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)         -- Go to next diagnostic
  vim.keymap.set('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts) -- Show diagnostic float

  -- Quickfix navigation for diagnostics
  vim.keymap.set('n', '<leader>q', function()
    -- Populate location list with diagnostics but don't focus it
    vim.diagnostic.setloclist({ open = false })

    -- Get the current window to restore focus later
    local current_window = vim.api.nvim_get_current_win()

    -- Toggle location list: if it has entries, open it; otherwise, close it
    vim.cmd("lwindow")

    -- Restore focus to the window you were working in
    vim.api.nvim_set_current_win(current_window)
  end)
end

-- Dynamically setup the config for every language
mason_lspconfig.setup_handlers({
  function(server_name)
    lspconfig[server_name].setup {
      on_attach = on_attach,
    }
  end
})

-- Manually setup configs for specified language
-- Note: need to re-apply the dynamic setup

-- Lua (lua_ls)
lspconfig.lua_ls.setup {
  on_attach = on_attach,
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      },
    },
  }
}
