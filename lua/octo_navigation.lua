local api = vim.api

vim.keymap.set("n", "<localleader>gd", function()
  local ok, reviews = pcall(require, "octo.reviews")
  local review = ok and reviews.get_current_review()

  if not review then
    vim.lsp.buf.definition()
    return
  end

  local layout = review.layout
  local root = vim.fs.root(0, ".git")

  if not root or api.nvim_get_current_win() ~= layout.right_winid then
    vim.notify("Use this from the right local diff pane")
    return
  end

  local function normalize(path)
    return vim.uv.fs_realpath(path) or vim.fs.normalize(path)
  end

  local function jump(item)
    if not item then return end

    local path = item.filename
    if not path and item.bufnr then
      path = api.nvim_buf_get_name(item.bufnr)
    end
    if not path or path == "" then return end

    path = normalize(path)

    -- If the target belongs to this PR, open its diff.
    for _, file in ipairs(layout.files) do
      local target = normalize(
        vim.fs.joinpath(root, file.path)
      )

      if target == path then
        api.nvim_set_current_tabpage(layout.tabpage)
        layout:set_current_file(file, "right")

        api.nvim_win_set_cursor(
          layout.right_winid,
          { item.lnum, math.max(0, item.col - 1) }
        )

        vim.cmd("normal! zvzz")
        return
      end
    end

    -- Otherwise, preserve the review in its own tab.
    vim.cmd("tabedit " .. vim.fn.fnameescape(path))
    api.nvim_win_set_cursor(0, {
      item.lnum,
      math.max(0, item.col - 1),
    })
    vim.cmd("normal! zz")
  end

  vim.lsp.buf.definition({
    on_list = function(result)
      if #result.items == 1 then
        jump(result.items[1])
      else
        vim.ui.select(result.items, {
          prompt = "Select definition",
          format_item = function(item)
            return (item.filename or
                  api.nvim_buf_get_name(item.bufnr))
                .. ":" .. item.lnum
          end,
        }, jump)
      end
    end,
  })
end, { desc = "Go to definition in PR diff" })
