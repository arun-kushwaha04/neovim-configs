return {
  "nvim-treesitter/nvim-treesitter-context",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    max_lines = 4,
    multiline_threshold = 3,
    on_attach = function(buf)
      -- Preserve the side-by-side layout and avoid plugin-managed buffers.
      return vim.bo[buf].buftype == "" and not vim.wo.diff
    end,
  },
  keys = {
    { "<leader>ch", "<cmd>TSContextToggle<CR>", desc = "Toggle sticky function context" },
  },
}
