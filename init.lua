-- Map leader, currently it's space
vim.g.mapleader = " "

-- diagnostic
vim.diagnostic.config({
  virtual_text = {
    spacing = 4,
    prefix = "●",
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,

  float = {
    border = "rounded",
    source = true,
  },
})

vim.keymap.set("n", "<leader>ce", function()
  vim.diagnostic.open_float()
end, { desc = "Show diagnostic" })

vim.keymap.set("n", "[d", function()
  vim.diagnostic.jump({ count = -1 })
end, { desc = "Previous diagnostic" })

vim.keymap.set("n", "]d", function()
  vim.diagnostic.jump({ count = 1 })
end, { desc = "Next diagnostic" })


-- Basic editor settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.smartindent = true
vim.opt.clipboard = "unnamedplus"

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local output = vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "--branch=stable",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
  if vim.v.shell_error ~= 0 then
    error("Failed to install lazy.nvim: " .. output)
  end
end

vim.opt.rtp:prepend(lazypath)

-- Vim background
vim.opt.termguicolors = true

local function set_transparent_bg()
  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
  vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
  vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
  vim.api.nvim_set_hl(0, "Folded", { bg = "none" })
  vim.api.nvim_set_hl(0, "NonText", { bg = "none" })
  vim.api.nvim_set_hl(0, "SpecialKey", { bg = "none" })
  vim.api.nvim_set_hl(0, "VertSplit", { bg = "none" })
  vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })
  vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "none" })
end

set_transparent_bg()

-- key bindings for options + up/down-- Move lines in Normal mode
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==")
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==")
vim.keymap.set("x", "<A-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("x", "<A-k>", ":m '<-2<CR>gv=gv")

-- close quick list
vim.keymap.set("n", "<leader>cq", function()
  vim.cmd("cclose")
end, { desc = "Close Quickfix" })

-- buffer line - tab switching
vim.keymap.set("n", "<Tab>", "<cmd>tabnext<CR>",
  { desc = "Next tab" })

vim.keymap.set("n", "<S-Tab>", "<cmd>tabprevious<CR>",
  { desc = "Previous tab" })

vim.keymap.set("n", "<leader>tn", "<cmd>tabnew<CR>",
  { desc = "New tab" })

vim.keymap.set("n", "<leader>tc", "<cmd>tabclose<CR>",
  { desc = "Close tab" })

-- Loads plugins.lua and plugins/*.lua
require("lazy").setup("plugins")

-- Configure installed plugins
require("lsp")
require("completion")
require("treesitter")
