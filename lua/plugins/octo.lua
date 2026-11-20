return {
  "pwntester/octo.nvim",
  cmd = "Octo",

  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-tree/nvim-web-devicons",
  },

  opts = {
    picker = "telescope",
    enable_builtin = true,
    -- Use actual local files in the right diff pane
    use_local_fs = true,
    reviews = {
      auto_show_threads = true,
      focus = "right",
      show_virtual_text = true,
    },
  },

  keys = {
    {
      "<leader>op",
      "<cmd>Octo pr list<CR>",
      desc = "List pull requests",
    },
    {
      "<leader>oi",
      "<cmd>Octo issue list<CR>",
      desc = "List GitHub issues",
    },
    {
      "<leader>on",
      "<cmd>Octo notification list<CR>",
      desc = "GitHub notifications",
    },
    {
      "<leader>or",
      "<cmd>Octo review start<CR>",
      desc = "Start PR review",
    },
  },
}
