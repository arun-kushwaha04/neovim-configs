return {
  "goolord/alpha-nvim",
  lazy = false,
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")
    dashboard.section.header.val = {
      "███╗   ██╗██╗   ██╗██╗███╗   ███╗",
      "████╗  ██║██║   ██║██║████╗ ████║",
      "██╔██╗ ██║██║   ██║██║██╔████╔██║",
      "██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║",
      "██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║",
      "╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝",
      "",
      "      Welcome to Neovim",
    }
    dashboard.section.buttons.val = {
      dashboard.button("e", "New file", "<cmd>ene<CR>"),
      dashboard.button("f", "Find file", "<cmd>Telescope find_files<CR>"),
      dashboard.button("r", "Recent files", "<cmd>Telescope oldfiles<CR>"),
      dashboard.button("g", "Search project", "<cmd>Telescope live_grep<CR>"),
      dashboard.button("q", "Quit", "<cmd>qa<CR>"),
    }
    alpha.setup(dashboard.config)
  end,
}
