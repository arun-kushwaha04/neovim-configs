return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = "Trouble",
  opts = {},
  keys = {
    { "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>", desc = "Workspace diagnostics" },
    { "<leader>xe", "<cmd>Trouble diagnostics toggle filter.severity=vim.diagnostic.severity.ERROR<CR>", desc = "Errors only" },
    { "<leader>xb", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Buffer diagnostics" },
    { "<leader>xs", "<cmd>Trouble symbols toggle focus=false<CR>", desc = "Document symbols" },
    { "<leader>xr", "<cmd>Trouble lsp toggle focus=false win.position=right<CR>", desc = "LSP locations" },
    { "<leader>xq", "<cmd>Trouble qflist toggle<CR>", desc = "Quickfix results" },
  },
}
