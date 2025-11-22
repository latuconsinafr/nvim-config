return {
  "christoomey/vim-tmux-navigator", -- Plugin to navigate vim insie tmux
  lazy = false,
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
    "TmuxNavigatePrevious",
    "TmuxNavigatorProcessList",
  },
  keys = {
    -- Bind nvim command to tmux command
    { "<C-h>",  "<cmd>TmuxNavigateLeft<cr>",     desc = "Navigate Left" },
    { "<C-j>",  "<cmd>TmuxNavigateDown<cr>",     desc = "Navigate Down" },
    { "<C-k>",  "<cmd>TmuxNavigateUp<cr>",       desc = "Navigate Up" },
    { "<C-l>",  "<cmd>TmuxNavigateRight<cr>",    desc = "Navigate Right" },
    { "<C-\\>", "<cmd>TmuxNavigatePrevious<cr>", desc = "Navigate Previous" },
  },
}
