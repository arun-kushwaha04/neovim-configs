local capabilities =
    require("cmp_nvim_lsp").default_capabilities()

-- C/C++
vim.lsp.config("clangd", {
  capabilities = capabilities,

  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
  },
})

-- TypeScript / JavaScript
vim.lsp.config("tsc", {
  capabilities = capabilities,
})

-- ESLint for JavaScript / TypeScript
vim.lsp.config("eslint", {
  capabilities = capabilities,

  settings = {
    workingDirectory = {
      mode = "auto",
    },
    format = false,
  },
})

-- Lua (for editing Neovim config)
vim.lsp.config("lua_ls", {
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
    },
  },
})

-- Keybindings when LSP attaches
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    local opts = { buffer = event.buf }

    vim.keymap.set(
      "n", "gd", vim.lsp.buf.definition, opts
    )

    vim.keymap.set(
      "n", "gr", vim.lsp.buf.references, opts
    )

    vim.keymap.set(
      "n", "K", vim.lsp.buf.hover, opts
    )

    vim.keymap.set(
      "n", "<leader>rn", vim.lsp.buf.rename, opts
    )

    vim.keymap.set(
      "n", "<leader>ca", vim.lsp.buf.code_action, opts
    )
  end,
})

-- Install and automatically enable LSP servers
require("mason").setup()

require("mason-lspconfig").setup({
  ensure_installed = {
    "tsc",
    "lua_ls",
    "eslint",
  },
  automatic_enable = true,
})
