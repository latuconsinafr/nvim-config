return {
  "danymat/neogen",                    -- Plugin for generating docstrings automatically
  dependencies = {
    "nvim-treesitter/nvim-treesitter", -- Neogen relies on Treesitter to parse code
  },
  config = function()
    -- Setup Neogen with per-language docstring conventions
    require("neogen").setup({
      enabled = true,
      languages = {
        -- Add more languages and conventions here if needed
      },
    })

    -- Keymap: gcd to generate a docstring with Neogen
    vim.keymap.set("n", "gcd", function()
      require("neogen").generate()
    end, { desc = "Generate docstring with Neogen" })

    -- Keymap for specified annotations
    vim.keymap.set("n", "<leader>nf", function()
      require("neogen").generate({ type = "func" })
    end, { desc = "Generate function docstring" })

    vim.keymap.set("n", "<leader>nc", function()
      require("neogen").generate({ type = "class" })
    end, { desc = "Generate class docstring" })

    vim.keymap.set("n", "<leader>nt", function()
      require("neogen").generate({ type = "type" })
    end, { desc = "Generate type docstring" })

    vim.keymap.set("n", "<leader>nF", function()
      require("neogen").generate({ type = "file" })
    end, { desc = "Generate file docstring" })
  end,
}
