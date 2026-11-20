
return {
  "linrongbin16/gitlinker.nvim",
  cmd = "GitLink",

  opts = {},

  keys = {
    {
      "<leader>gy",
      "<cmd>GitLink<CR>",
      mode = { "n", "v" },
      desc = "Copy GitHub permalink",
    },
    {
      "<leader>gY",
      "<cmd>GitLink!<CR>",
      mode = { "n", "v" },
      desc = "Open GitHub permalink",
    },
    {
      "<leader>gb",
      "<cmd>GitLink current_branch<CR>",
      mode = { "n", "v" },
      desc = "Copy GitHub branch link",
    },
    {
      "<leader>gm",
      "<cmd>GitLink default_branch<CR>",
      mode = { "n", "v" },
      desc = "Copy default branch link",
    },
  },
}

