local neogen = require('neogen')

-- Setup
neogen.setup {
  enabled = true,             -- if you want to disable Neogen
  input_after_comment = true, -- (default: true) automatic jump (with insert mode) on inserted annotation
  languages = {
    lua = {
      template = {
        annotation_convention = "ldoc"
      }
    },
    javascript = {
      template = {
        annotation_convention = "jsdoc"
      }
    },
    typescript = {
      template = {
        annotation_convention = "tsdoc"
      }
    },
    rust = {
      template = {
        annotation_convention = "rustdoc"
      }
    }
  }
}

-- Keymaps
local opts = { noremap = true, silent = true }

vim.api.nvim_set_keymap('n', '<leader>nf', ":lua require('neogen').generate({ type = 'func' })<CR>",
  opts)
vim.api.nvim_set_keymap('n', '<leader>nc', ":lua require('neogen').generate({ type = 'class' })<CR>",
  opts)
vim.api.nvim_set_keymap('n', '<leader>nt', ":lua require('neogen').generate({ type = 'type' })<CR>",
  opts)
vim.api.nvim_set_keymap('n', '<leader>nF', ":lua require('neogen').generate({ type = 'file' })<CR>",
  opts)
