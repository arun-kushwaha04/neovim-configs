return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    current_line_blame = false,
    on_attach = function(bufnr)
      local gs = require("gitsigns")
      local function map(key, fn, desc)
        vim.keymap.set("n", key, fn, { buffer = bufnr, desc = desc })
      end
      map("]h", function() gs.nav_hunk("next") end, "Next Git hunk")
      map("[h", function() gs.nav_hunk("prev") end, "Previous Git hunk")
      map("<leader>hp", gs.preview_hunk, "Preview Git hunk")
      map("<leader>hs", gs.stage_hunk, "Stage Git hunk")
      map("<leader>hr", gs.reset_hunk, "Reset Git hunk")
      map("<leader>hb", function() gs.blame_line({ full = true }) end, "Git blame line")
      map("<leader>hd", gs.diffthis, "Diff current file")
    end,
  },
}
