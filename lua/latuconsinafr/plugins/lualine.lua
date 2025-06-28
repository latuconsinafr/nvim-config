return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local function hide_below(width)
      return function() return vim.o.columns > width end
    end

    require('lualine').setup {
      options = {
        theme = 'auto',
        section_separators = { left = '', right = '' }, -- nice rounded separators
        component_separators = { left = '', right = '' },
        globalstatus = true,
      },
      sections = {
        lualine_a = {
          { 'mode' },
        },
        lualine_b = {
          { 'branch',     cond = hide_below(100) },
          { 'diff',       cond = hide_below(170) },
          { 'diagnostics' }
        },
        lualine_c = {
          {
            'filename',
            path = 1,
            cond = hide_below(130),
          },
        },
        lualine_x = {
          { 'encoding',   cond = hide_below(110) },
          { 'fileformat', cond = hide_below(120) },
          { 'filetype',   cond = hide_below(150) },
        },
        lualine_y = {
          { 'progress' },
        },
        lualine_z = {
          { 'location' },
        },
      },
    }
  end,
}
