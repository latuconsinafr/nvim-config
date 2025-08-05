return {
  "gbprod/yanky.nvim",
  dependencies = {
    "kkharji/sqlite.lua",
  },
  config = function()
    require("yanky").setup({
      ring = {
        history_length = 100,
        storage = "sqlite",
        storage_path = vim.fn.stdpath("data") .. "/databases/yanky.db",
        ignore_registers = { "_" },
      },
      system_clipboard = {
        sync_with_ring = true,
      },
      highlight = {
        on_put = true,
        on_yank = true,
        timer = 100,
      },
    })

    -- Basic keymaps
    -- Paste after cursor using Yanky (preserves default register history)
    vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")

    -- Paste before cursor using Yanky
    vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")

    -- Cycle to previous yank in the yank history
    vim.keymap.set("n", "<C-p>", "<Plug>(YankyPreviousEntry)")

    -- Cycle to next yank in the yank history
    vim.keymap.set("n", "<C-n>", "<Plug>(YankyNextEntry)")

    -- Open a searchable popup list past yanks (like a clipboard manager with fzf lua)
    vim.keymap.set("n", "<leader>fy", function()
      -- Get yanky history directly from the ring
      local ok, yanky_history = pcall(require, "yanky.history")

      if not ok then
        print("Yanky history not available")

        return
      end

      local entries = {}
      local contents = {}

      -- Try to get history items
      local history_items = yanky_history.all() or {}

      for i, item in ipairs(history_items) do
        local content = item.regcontents or item.content or ""

        if type(content) == "table" then
          content = table.concat(content, "\n")
        end

        if content ~= "" then
          local preview = content:gsub("\n", " "):sub(1, 80)
          table.insert(entries, string.format("%d: %s", i, preview))
          table.insert(contents, content)
        end
      end

      if #entries == 0 then
        print("No yank history")

        return
      end

      require('fzf-lua').fzf_exec(entries, {
        prompt = "Yank History ❯ ",
        preview_window = "right:50%",
        preview = function(selected)
          local idx = tonumber(selected[1]:match("^(%d+):"))
          return contents[idx] or ""
        end,
        actions = {
          ['default'] = function(selected)
            local idx = tonumber(selected[1]:match("^(%d+):"))
            if contents[idx] then
              vim.fn.setreg('"', contents[idx])
              vim.api.nvim_paste(contents[idx], false, -1)
            end
          end,
          ['ctrl-y'] = function(selected)
            local idx = tonumber(selected[1]:match("^(%d+):"))
            if contents[idx] then
              vim.fn.setreg('"', contents[idx])
              vim.fn.setreg('+', contents[idx])

              print("Copied to clipboard")
            end
          end,
        }
      })
    end, { desc = "Yank history" })
  end,
}
