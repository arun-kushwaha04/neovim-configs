-- tokyonight theme
-- return {
--   "folke/tokyonight.nvim",
--   lazy = false,
--   priority = 1000,
--   opts = {
--     transparent = true,
--   },
--   config = function(_, opts)
--     require("tokyonight").setup(opts)
--     vim.cmd.colorscheme("tokyonight")
--   end,
-- }

-- kanagawa theme
return {
  "rebelot/kanagawa.nvim",
  lazy = false,
  priority = 1000,

  opts = {
    transparent = true,
    undercurl = true,
    dimInactive = false,
    terminalColors = true,

    commentStyle = { italic = true },
    keywordStyle = { italic = true },

    colors = {
      theme = {
        all = {
          ui = {
            bg_gutter = "none",
          },
        },
      },
    },
    overrides = function()
      return {
        NormalFloat             = {
          fg = "#292622",
          bg = "#eae4d6",
        },
        FloatBorder             = {
          fg = "#a09887",
          bg = "#eae4d6",
        },
        FloatTitle              = {
          fg = "#292622",
          bg = "#eae4d6",
          bold = true,
        },

        -- Diagnostic colors inside floating windows
        DiagnosticFloatingError = { fg = "#a32b32" },
        DiagnosticFloatingWarn  = { fg = "#986000" },
        DiagnosticFloatingInfo  = { fg = "#245a99" },
        DiagnosticFloatingHint  = { fg = "#397354" },
      }
    end
  },

  config = function(_, opts)
    require("kanagawa").setup(opts)
    vim.cmd.colorscheme("kanagawa-wave")
  end,
}
