return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  branch = "main",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  lazy = false,
  config = function()
    require("nvim-treesitter-textobjects").setup({
      select = { lookahead = false, selection_modes = { ["@function.outer"] = "V", ["@class.outer"] = "V" } },
      move = { set_jumps = true },
    })
    local select = require("nvim-treesitter-textobjects.select")
    local move = require("nvim-treesitter-textobjects.move")
    local function textobject(key, capture, desc)
      vim.keymap.set({ "x", "o" }, key, function()
        select.select_textobject(capture, "textobjects")
      end, { desc = desc })
    end
    textobject("af", "@function.outer", "Entire function")
    textobject("if", "@function.inner", "Function body")
    textobject("ac", "@class.outer", "Entire class")
    textobject("ic", "@class.inner", "Class body")
    textobject("aa", "@parameter.outer", "Entire parameter")
    textobject("ia", "@parameter.inner", "Inner parameter")

    vim.keymap.set({ "n", "x", "o" }, "[m", function()
      move.goto_previous_start("@function.outer", "textobjects")
    end, { desc = "Previous function start" })
    vim.keymap.set({ "n", "x", "o" }, "]m", function()
      move.goto_next_start("@function.outer", "textobjects")
    end, { desc = "Next function start" })
    vim.keymap.set({ "n", "x", "o" }, "[M", function()
      move.goto_previous_end("@function.outer", "textobjects")
    end, { desc = "Previous function end" })
    vim.keymap.set({ "n", "x", "o" }, "]M", function()
      move.goto_next_end("@function.outer", "textobjects")
    end, { desc = "Next function end" })
  end,
}
