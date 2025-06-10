return {
  {
    -- Plugin for modern and smooth folding in Neovim
    "kevinhwang91/nvim-ufo",
    -- Optional dependency for promise-based async (required by ufo)
    dependencies = {
      "kevinhwang91/promise-async",      -- Required for async functionality
      "nvim-treesitter/nvim-treesitter", -- Optional: for better fold parsing
    },
    -- Load immediately since it configures fold behavior
    lazy = false,
    config = function()
      -- Folding settings to allow full visibility at startup
      vim.o.foldcolumn = "1"    -- Show fold column (like sign column)
      vim.o.foldlevel = 99      -- High default so folds are open
      vim.o.foldlevelstart = 99 -- Same as above when opening files
      vim.o.foldenable = true   -- Enable folding by default

      -- Setup nvim-ufo with provider priorities
      require("ufo").setup({
        provider_selector = function(bufnr, filetype, buftype)
          -- Try treesitter first, fall back to indent
          return { "treesitter", "indent" }
        end,
      })
    end,
  },
}
