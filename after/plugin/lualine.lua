local lualine = require('lualine')

-- Setup
lualine.setup {
  sections = {
    lualine_a = {
      {
        'mode',
        cond = function()
          return vim.fn.winwidth(0) > 40 -- Show mode if window width is greater than 40
        end
      }
    },
    lualine_b = {
      {
        'branch',
        cond = function()
          return vim.fn.winwidth(0) > 80 -- Show branch if window width is greater than 80
        end
      },
      {
        'diff',
        cond = function()
          return vim.fn.winwidth(0) > 80 -- Show diff if window width is greater than 80
        end
      },
      {
        'diagnostics',
        cond = function()
          return vim.fn.winwidth(0) > 40 -- Show diagnostics if window width is greater than 40
        end
      }
    },
    lualine_c = {
      {
        'filename',
        path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
      }
    },
    lualine_x = {
      {
        'encoding',
        cond = function()
          return vim.fn.winwidth(0) > 80 -- Show encoding if window width is greater than 80
        end
      },
      {
        'fileformat',
        cond = function()
          return vim.fn.winwidth(0) > 80 -- Show fileformat if window width is greater than 80
        end
      },
      {
        'filetype',
        cond = function()
          return vim.fn.winwidth(0) > 80 -- Show filetype if window width is greater than 80
        end
      }
    },
    lualine_y = {
      {
        'progress',
        cond = function()
          return vim.fn.winwidth(0) > 60 -- Show progress if window width is greater than 60
        end
      }
    },
    lualine_z = {
      {
        'location',
        cond = function()
          return vim.fn.winwidth(0) > 80 -- Show location if window width is greater than 80
        end
      }
    }
  },
}
