return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  lazy = false,

  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },

  opts = {
    close_if_last_window = true,
    enable_git_status = true,
    enable_diagnostics = true,
    auto_clean_after_session_restore = true,

    window = {
      position = "left",
      width = 35,

      mappings = {
        ["<space>"] = "toggle_node",
        ["<cr>"] = "open",
        ["s"] = "open_vsplit",
        ["S"] = "open_split",
        ["t"] = "open_tabnew",
        ["q"] = "close_window",
      },
    },

    filesystem = {
      bind_to_cwd = false,

      follow_current_file = {
        enabled = true,
        leave_dirs_open = false,
      },

      group_empty_dirs = true,
      use_libuv_file_watcher = true,
      hijack_netrw_behavior = "open_default",

      filtered_items = {
        visible = false,
        hide_dotfiles = false,
        hide_gitignored = false,

        never_show = {
          ".git",
          "node_modules",
        },
      },
    },
  },

  keys = {
    {
      "<leader>fe",
      function()
        local root = vim.fs.root(0, ".git")
            or vim.fs.root(vim.uv.cwd(), ".git")
            or vim.uv.cwd()

        require("neo-tree.command").execute({
          source = "filesystem",
          position = "left",
          toggle = true,
          reveal = true,
          dir = root,
        })
      end,
      desc = "Toggle file explorer",
    },
    { "<leader>ef", "<cmd>Neotree focus<CR>", desc = "Focus file explorer" },
  },
}
