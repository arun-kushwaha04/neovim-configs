local function playground_dir()
  local root = vim.fs.root(vim.uv.cwd(), ".git")
      or vim.uv.cwd()

  return root .. "/tarpon/scripts/playground-scripts"
end

return {
  "nvim-telescope/telescope.nvim",
  version = "*",
  cmd = "Telescope",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
  },
  opts = {
    defaults = {
      layout_strategy = "horizontal",
      layout_config = { horizontal = { preview_width = 0.55 } },
      sorting_strategy = "ascending",
      file_ignore_patterns = { "node_modules/", "%.git/", "dist/", "build/" },
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--ignore-case",
      },
    },
    pickers = {
      find_files = { hidden = true },
      live_grep = {
        mappings = {
          i = {
            ["<C-Space>"] = function(prompt_bufnr)
              require("telescope.actions").to_fuzzy_refine(prompt_bufnr)
            end,
          },
        },
      },
    },
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "ignore_case",
      },
    },
  },
  config = function(_, opts)
    local telescope = require("telescope")
    telescope.setup(opts)
    pcall(telescope.load_extension, "fzf")
  end,
  keys = {
    { "<leader>ff", function() require("telescope.builtin").find_files() end,           desc = "Find files" },
    { "<leader>fg", function() require("telescope.builtin").live_grep() end,            desc = "Search text in project" },
    { "<leader>fb", function() require("telescope.builtin").buffers() end,              desc = "Find open buffers" },
    { "<leader>fr", function() require("telescope.builtin").oldfiles() end,             desc = "Recent files" },
    { "<leader>fp", function() require("telescope.builtin").git_files() end,            desc = "Find Git files" },
    { "<leader>fs", function() require("telescope.builtin").lsp_document_symbols() end, desc = "Document symbols" },
    {
      "<leader>fF",
      function()
        require("telescope.builtin").find_files({
          cwd = playground_dir(),
          no_ignore = true,
          hidden = true,
          prompt_title = "Find Playground Scripts",
        })
      end,
      desc = "Find playground scripts",
    },
    {
      "<leader>fG",
      function()
        require("telescope.builtin").live_grep({
          cwd = playground_dir(),
          additional_args = {
            "--no-ignore",
            "--hidden",
          },
          prompt_title = "Search Playground Scripts",
        })
      end,
      desc = "Search playground scripts",
    },
    {
      "<leader>fl",
      function()
        require("telescope.builtin").resume()
      end,
      desc = "Resume last search",
    },
    { "<leader>fw", function() require("telescope.builtin").grep_string() end, desc = "Search word under cursor" },
    { "<leader>fd", function() require("telescope.builtin").diagnostics() end, desc = "Search diagnostics" },
    {
      "<leader>fE",
      function()
        require("telescope.builtin").diagnostics({
          severity = vim.diagnostic.severity.ERROR,
        })
      end,
      desc = "Find errors only",
    },
    {
      "<leader>fn",
      function()
        require("telescope.builtin").find_files({
          cwd = vim.fn.expand("%:p:h"),
        })
      end,
      desc = "Find neighbouring files",
    },
  },
}
