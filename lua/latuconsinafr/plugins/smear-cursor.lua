return {
  "sphamba/smear-cursor.nvim", -- The smear cursor repo
  name = "smear-cursor",       -- Name for easy reference inside lazy.nvim

  -- Enabled/Disabled
  enabled = true,

  opts = {
    -- Smear cursor when switching buffers or windows.
    smear_between_buffers = true,

    -- Smear cursor when moving within line or to neighbor lines.
    -- Use `min_horizontal_distance_smear` and `min_vertical_distance_smear` for finer control
    smear_between_neighbor_lines = true,

    -- Draw the smear in buffer space instead of screen space when scrolling
    scroll_buffer_space = true,

    -- Set to `true` if your font supports legacy computing symbols (block unicode symbols).
    -- Smears will blend better on all backgrounds.
    legacy_computing_symbols_support = false,

    -- Smear cursor in insert mode.
    -- See also `vertical_bar_cursor_insert_mode` and `distance_stop_animating_vertical_bar`.
    smear_insert_mode = false,

    -- Smear cursor when entering or leaving command line mode
    smear_to_cmd = false,

    -- Smear cursor color. Defaults to Cursor GUI color if not set.
    -- Set to "none" to match the text color at the target cursor position.
    -- cursor_color = "#ffffff",

    -- Faster smear
    stiffness = 0.8,                      -- 0.6      [0, 1]
    trailing_stiffness = 0.5,             -- 0.4      [0, 1]
    stiffness_insert_mode = 0.7,          -- 0.5      [0, 1]
    trailing_stiffness_insert_mode = 0.7, -- 0.5      [0, 1]
    damping = 0.8,                        -- 0.65     [0, 1]
    damping_insert_mode = 0.8,            -- 0.7      [0, 1]
    distance_stop_animating = 0.5,        -- 0.1      > 0

    -- Smooth cursor without smear
    -- stiffness = 0.5,
    -- trailing_stiffness = 0.5,
    -- damping = 0.67,
    -- matrix_pixel_threshold = 0.5,

    -- Time interval between draws
    time_interval = 12, -- milliseconds

    -- Set to `true` to prevent the smear from overlapping the target character, hiding it until the animation is over.
    never_draw_over_target = true,

    -- Delay for `vim.on_key` to avoid redundancy with vim events triggers.
    delay_after_key = 10 -- milliseconds
  },
}
