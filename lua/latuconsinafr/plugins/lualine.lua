return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('lualine').setup {
      options = {
        theme = 'auto',
        section_separators = { left = '', right = '' }, -- nice rounded separators
        component_separators = { left = '', right = '' },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch' },
        lualine_c = { 'filename' }, -- filename only on statusline
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
      winbar = {
        lualine_a = {
          {
            'filename',
            file_status = true,     -- Shows [Modified], [Readonly]
            newfile_status = true,  -- Show [New] for new files
            path = 1,               -- 0 = just filename, 1 = relative path
            symbols = {
              modified = ' ●',      -- Text to show when the file is modified
              readonly = ' ',      -- Icon for readonly
              unnamed = '[No Name]',
              newfile = '[New]',
            }
          }
        }
      }
    }
  end,
}
