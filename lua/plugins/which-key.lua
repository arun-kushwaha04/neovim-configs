return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "modern",
    delay = 300,
    spec = {
      { "<leader>f", group = "Find" },
      { "<leader>h", group = "Git hunks" },
      { "<leader>c", group = "Code" },
      { "<leader>r", group = "Refactor" },
      { "<leader>z", group = "Folding" },
      { "<leader>d", group = "Debug" },
      { "<leader>x", group = "Problems" },
      { "<leader>j", group = "Tasks" },
      { "<leader>t", group = "Tests / tabs" },
      { "<leader>o", group = "GitHub" },
      { "<leader>g", group = "Git" },
      { "<leader>e", group = "Explorer" },
    },
  },
  keys = {
    {
      "<leader>?",
      function() require("which-key").show({ global = false }) end,
      desc = "Buffer keymaps",
    },
  },
}
