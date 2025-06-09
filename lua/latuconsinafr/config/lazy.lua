-- Bootstrap lazy.nvim: ensure lazy.nvim is installed automatically if missing
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Check if lazy.nvim folder exists, if not clone the stable branch from GitHub
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  -- Clone lazy.nvim repo with minimal history (filter=blob:none) for faster cloning
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })

  -- If cloning fails (non-zero exit code), notify user and exit Neovim
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

-- Add lazy.nvim path to the beginning of runtimepath so Neovim loads it first
vim.opt.rtp:prepend(lazypath)

-- Set leader keys BEFORE loading lazy.nvim so plugins use correct mappings
vim.g.mapleader = " "        -- Leader key set to space bar
vim.g.maplocalleader = "\\"  -- Local leader key set to backslash

-- Call lazy.nvim setup with configuration table
require("lazy").setup({
  -- Specify plugin specs by importing Lua modules/folders with plugin lists
  spec = {
    { import = "latuconsinafr.plugins" },               -- Main plugin specs
    { import = "latuconsinafr.plugins.color-schemes" }, -- Color schemes plugins
  },

  -- Automatically install specified colorschemes during plugin setup
  install = { colorscheme = { "habamax" } },

  -- Enable automatic plugin update checks (runs in the background)
  checker = { enabled = true },
})

