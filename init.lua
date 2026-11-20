-- Map leader, currently it's space
vim.g.mapleader = " "
vim.g.maplocalleader = ","

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

-- Navigate errors only
vim.keymap.set("n", "]e", function()
  vim.diagnostic.jump({
    count = 1,
    severity = vim.diagnostic.severity.ERROR,
  })
end, { desc = "Next error" })

vim.keymap.set("n", "[e", function()
  vim.diagnostic.jump({
    count = -1,
    severity = vim.diagnostic.severity.ERROR,
  })
end, { desc = "Previous error" })

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
vim.opt.winblend = 0
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.scrolloff = 8
vim.opt.undofile = true

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlighting" })
vim.keymap.set("n", "n", "nzz", { desc = "Next search match" })
vim.keymap.set("n", "N", "Nzz", { desc = "Previous search match" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })

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

-- split settings
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.rtp:prepend(lazypath)

-- Vim background
vim.opt.termguicolors = true

local function set_transparent_bg()
  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  -- diagnostic popup to have different color as theme, while setting unset winblend
  -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
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

-- toggle quick list
vim.keymap.set("n", "<leader>cq", function()
  if vim.fn.getqflist({ winid = 0 }).winid ~= 0 then
    vim.cmd("cclose")
  else
    vim.cmd("copen")
  end
end, { desc = "Toggle Quickfix" })

-- Native tab navigation; keep Ctrl+i / Tab for forward jump history.
vim.keymap.set("n", "<leader>tn", "<cmd>tabnew<CR>",
  { desc = "New tab" })

vim.keymap.set("n", "<leader>t]", "<cmd>tabnext<CR>",
  { desc = "Next tab" })
vim.keymap.set("n", "<leader>t[", "<cmd>tabprevious<CR>",
  { desc = "Previous tab" })

-- Enable manual folding
vim.keymap.set("n", "<leader>zm", function()
  vim.opt_local.foldmethod = "manual"
  vim.opt_local.foldenable = true
  vim.notify("Manual folding enabled")
end, { desc = "Enable manual folding" })

-- Restore diff folding
vim.keymap.set("n", "<leader>zd", function()
  vim.opt_local.foldmethod = "diff"
  vim.notify("Diff folding enabled")
end, { desc = "Enable diff folding" })

-- Enable Treesitter folding
vim.keymap.set("n", "<leader>zt", function()
  vim.opt_local.foldmethod = "expr"
  vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
  vim.opt_local.foldenable = true
  vim.opt_local.foldlevel = 99
  vim.notify("Treesitter folding enabled")
end, { desc = "Enable Treesitter folding" })

-- tabs and splits
vim.keymap.set("n", "<leader>wc", "<cmd>close<CR>",
  { desc = "Close window" })

vim.keymap.set("n", "<leader>wo", "<cmd>only<CR>",
  { desc = "Close other windows" })

vim.keymap.set("n", "<leader>tc", "<cmd>tabclose<CR>",
  { desc = "Close tab" })

vim.keymap.set("n", "<leader>to", "<cmd>tabonly<CR>",
  { desc = "Close other tabs" })

-- Loads plugins.lua and plugins/*.lua
require("lazy").setup("plugins")

-- Configure installed plugins
require("lsp")
require("completion")
require("treesitter")
require("popup_style")
require("octo_navigation")
