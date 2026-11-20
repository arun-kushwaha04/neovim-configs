local api = vim.api
local ns = api.nvim_create_namespace("light_popups")

local palette = {
  bg = "#eae4d6",
  fg = "#292622",
  blue = "#174e91",
  green = "#386641",
  purple = "#633c85",
  orange = "#8b501c",
  red = "#a32b32",
  gray = "#625e55",
  border = "#a09887",
}

local groups = {
  Normal = { fg = palette.fg, bg = palette.bg },
  NormalFloat = { fg = palette.fg, bg = palette.bg },
  FloatBorder = { fg = palette.border, bg = palette.bg },

  FloatTitle = { fg = palette.purple, bold = true },

  Comment = { fg = palette.gray, italic = true },
  String = { fg = palette.green },
  Function = { fg = palette.blue, bold = true },
  Keyword = { fg = palette.purple },
  Type = { fg = palette.orange },
  Identifier = { fg = palette.fg },
  Constant = { fg = palette.orange },
  Number = { fg = palette.orange },
  Special = { fg = palette.purple },

  -- Treesitter syntax highlighting
  ["@variable"] = { fg = palette.fg },
  ["@property"] = { fg = palette.blue },
  ["@function"] = { fg = palette.blue },
  ["@keyword"] = { fg = palette.purple },
  ["@type"] = { fg = palette.orange },
  ["@string"] = { fg = palette.green },
  ["@constant"] = { fg = palette.orange },
  ["@comment"] = { fg = palette.gray, italic = true },
  ["@punctuation"] = { fg = palette.gray },
  ["@markup.heading"] = { fg = palette.purple, bold = true },
  ["@markup.raw"] = { fg = palette.fg },
  ["@markup.link"] = { fg = palette.blue },

  -- Diagnostics
  DiagnosticFloatingError = { fg = palette.red },
  DiagnosticFloatingWarn = { fg = palette.orange },
  DiagnosticFloatingInfo = { fg = palette.blue },
  DiagnosticFloatingHint = { fg = palette.green },
}

for name, style in pairs(groups) do
  api.nvim_set_hl(ns, name, style)
end

-- Handle more specific Treesitter highlight groups
for name in pairs(api.nvim_get_hl(0, {})) do
  if name:sub(1, 1) == "@" then
    local parent = name

    while parent and not groups[parent] do
      parent = parent:match("^(.*)%.[^.]+$")
    end

    api.nvim_set_hl(ns, name,
      groups[parent] or { fg = palette.fg })
  end
end

-- Apply the palette only to LSP floating previews
api.nvim_create_autocmd("WinNew", {
  group = api.nvim_create_augroup("LightPopups", {
    clear = true,
  }),

  callback = function()
    vim.schedule(function()
      for _, win in ipairs(api.nvim_list_wins()) do
        local config = api.nvim_win_get_config(win)

        if config.relative ~= ""
            and vim.w[win].lsp_floating_bufnr then
          api.nvim_win_set_hl_ns(win, ns)
          vim.wo[win].winblend = 0
        end
      end
    end)
  end,
})

-- Mason popup styling
local function mason_highlights()
  vim.api.nvim_set_hl(0, "MasonNormal", {
    bg = "#eae4d6",
    fg = "#292622",
  })

  vim.api.nvim_set_hl(0, "MasonCursorLine", {
    bg = "#c8bba0",
    fg = "#292622",
    bold = true,
  })

  vim.api.nvim_set_hl(0, "MasonMuted", {
    fg = "#625e55",
  })
end

mason_highlights()

local group = vim.api.nvim_create_augroup("MasonStyle", {
  clear = true,
})

vim.api.nvim_create_autocmd("ColorScheme", {
  group = group,
  callback = mason_highlights,
})

vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = "mason",
  callback = function()
    vim.opt_local.winhighlight:append({
      CursorLine = "MasonCursorLine",
    })
  end,
})


-- Which-Key popup styling
local function style_which_key()
  local highlights = {
    WhichKeyNormal     = {
      fg = "#292622",
      bg = "#eae4d6",
    },
    WhichKeyBorder     = {
      fg = "#a09887",
      bg = "#eae4d6",
    },
    WhichKeyTitle      = {
      fg = "#292622",
      bg = "#eae4d6",
      bold = true,
    },

    -- Shortcut keys
    WhichKey           = {
      fg = "#174e91",
      bold = true,
    },

    -- Shortcut descriptions
    WhichKeyDesc       = {
      fg = "#292622",
    },

    -- Shortcut groups
    WhichKeyGroup      = {
      fg = "#633c85",
      bold = true,
    },

    WhichKeySeparator  = { fg = "#625e55" },
    WhichKeyValue      = { fg = "#625e55" },

    -- Icons
    WhichKeyIcon       = { fg = "#174e91" },
    WhichKeyIconAzure  = { fg = "#174e91" },
    WhichKeyIconBlue   = { fg = "#174e91" },
    WhichKeyIconCyan   = { fg = "#286b70" },
    WhichKeyIconGreen  = { fg = "#386641" },
    WhichKeyIconGrey   = { fg = "#625e55" },
    WhichKeyIconOrange = { fg = "#8b501c" },
    WhichKeyIconPurple = { fg = "#633c85" },
    WhichKeyIconRed    = { fg = "#a32b32" },
    WhichKeyIconYellow = { fg = "#986000" },
  }

  for group, style in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, style)
  end
end

style_which_key()

vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup(
    "WhichKeyStyle", { clear = true }
  ),
  callback = style_which_key,
})
