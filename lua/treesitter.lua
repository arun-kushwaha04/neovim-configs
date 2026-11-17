
local treesitter = require("nvim-treesitter")

treesitter.install({
  "javascript",
  "typescript",
  "tsx",
  "json",
  "jsonc",
  "html",
  "css",
  "lua",
  "markdown",
  "markdown_inline",
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "json",
    "jsonc",
    "html",
    "css",
    "lua",
    "markdown",
  },
  callback = function(event)
    pcall(vim.treesitter.start, event.buf)
  end,
})

