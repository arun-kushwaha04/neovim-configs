return {
  "sindrets/diffview.nvim",

  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
  },

  opts = {
    view = {
      merge_tool = {
        layout = "diff3_horizontal",
        disable_diagnostics = true,
        winbar_info = true,
      },
    },

    file_panel = {
      win_config = {
        position = "left",
        width = 30,
      },
    },
  },

  keys = {
    {
      "<leader>gd",
      "<cmd>DiffviewOpen<CR>",
      desc = "Open Git diff",
    },
    {
      "<leader>gc",
      "<cmd>DiffviewClose<CR>",
      desc = "Close Git diff",
    },
    {
      "<leader>gh",
      "<cmd>DiffviewFileHistory %<CR>",
      desc = "Current file Git history",
    },
  },
}
