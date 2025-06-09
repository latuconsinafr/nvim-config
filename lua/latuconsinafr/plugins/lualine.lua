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
        lualine_c = {
          {
            'filename',
            file_status = true,         -- Shows file status (readonly, modified)
            path = 1,                   -- 0 = just filename, 1 = relative path, 2 = absolute path
            shorting_target = 40,
            color = { fg = '#fabd2f' },
          }
        },
        options = {
          theme = 'auto',
        },
      },
    }
  end,
}
