
local treesitter = require("nvim-treesitter")

treesitter.install({
  "javascript",
  "typescript",
  "tsx",
  "json",
  "html",
  "css",
  "lua",
  "markdown",
  "markdown_inline",
  "c",
  "cpp",
  "bash",
  "yaml",
  "cmake",
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
    "c",
    "cpp",
    "sh",
    "bash",
    "yaml",
    "cmake",
  },
  callback = function(event)
    pcall(vim.treesitter.start, event.buf)
  end,
})
