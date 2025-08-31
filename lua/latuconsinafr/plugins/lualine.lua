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
          -- Since noice hide the recording message, so yeah
          {
            function()
              local ok, noice = pcall(require, "noice")
              if not ok then return "" end

              if noice.api.statusline.mode.has() then
                local msg = noice.api.statusline.mode.get()
                local recording = msg:match("recording @%a")

                -- Only show recording or empty
                return recording or ""
              end
              return ""
            end,
          },
        },
        lualine_b = {
          {
            'branch',
            cond = hide_below(100),
            fmt = function(str)
              if #str > 27 then
                -- Shorten common prefixes
                str = str:gsub("feature/", "feat/")
                str = str:gsub("bugfix/", "fix/")
                str = str:gsub("hotfix/", "hot/")

                -- Truncate if still too long
                if #str > 27 then
                  return str:sub(1, 24) .. "..."
                end
              end
              return str
            end
          },
          { 'diff',       cond = hide_below(170) },
          { 'diagnostics' }
        },
        lualine_c = {
          {
            'filename',
            path = 4, -- Smart path: shows filename, or relative path if needed
            shorting_target = 40, -- Truncate path if longer than 40 chars
            symbols = {
              modified = ' ●', -- Text to show when file is modified
              readonly = ' ', -- Text to show when file is non-modifiable
              unnamed = '[No Name]', -- Text to show for unnamed buffers
            },
            cond = hide_below(80),
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
