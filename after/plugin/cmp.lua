-- Load the nvim cmp plugin
local cmp = require('cmp')

-- Setup
cmp.setup({
  snippet = {
    -- Define how to expand snippets
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- For LuaSnip users: expand snippets using the LSP
    end,
  },
  mapping = {
    ['<C-n>'] = cmp.mapping.select_next_item(),        -- Navigate to the next completion item
    ['<C-p>'] = cmp.mapping.select_prev_item(),        -- Navigate to the previous completion item
    ['<C-Space>'] = cmp.mapping.complete(),            -- Trigger completion menu
    ['<C-e>'] = cmp.mapping.abort(),                   -- Abort completion
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Confirm the selected completion item
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),           -- Scroll documentation upwards
    ['<C-d>'] = cmp.mapping.scroll_docs(4),            -- Scroll documentation downwards
  },
  sources = {
    { name = 'copilot' },  -- Use copilot.lua as a source for completions
    { name = 'nvim_lsp' }, -- Use nvim_lsp as a source for LSP completions
    { name = 'buffer' },   -- Use buffer contents as a source for completions
    { name = 'path' },     -- Use filesystem paths as a source for completions
    { name = 'luasnip' },  -- Use LuaSnip snippets as a source for completions
    {
      name = 'spell',
      option = {
        keep_all_entries = false,
        enable_in_context = function()
          return true
        end,
        preselect_correct_word = true,
      },
    }, -- Use cmp-spell for highlighting misspelled words
  },
})

-- Configure spell capabilities
vim.opt.spell = true
vim.opt.spelllang = { "en_gb" }
