local function run_playground()
  local buf = vim.api.nvim_buf_get_name(0)
  if vim.bo.modified then
    vim.notify("Save the current buffer before running a playground script", vim.log.levels.WARN)
    return
  end
  local root = vim.fs.root(buf ~= "" and buf or vim.fn.getcwd(), ".git")
  if not root then
    vim.notify("No Git project found", vim.log.levels.WARN)
    return
  end
  local cwd = vim.fs.joinpath(root, "tarpon")
  local dir = vim.fs.joinpath(cwd, "scripts", "playground-scripts")
  if not vim.uv.fs_stat(dir) then
    cwd = root
    dir = vim.fs.joinpath(cwd, "scripts", "playground-scripts")
  end
  if not vim.uv.fs_stat(dir) then
    vim.notify("Playground directory not found", vim.log.levels.WARN)
    return
  end
  local function launch(name)
    if not name or name == "" then return end
    local task = require("overseer").new_task({
      name = "Playground: " .. name,
      cmd = { "yarn", "playground", name },
      cwd = cwd,
      components = { "default" },
    })
    task:start()
    vim.cmd("OverseerOpen")
  end
  local normalized = vim.fs.normalize(buf)
  local prefix = vim.fs.normalize(dir) .. "/"
  if vim.startswith(normalized, prefix) and normalized:sub(-3) == ".ts" then
    launch(normalized:sub(#prefix + 1, -4))
  else
    vim.ui.input({ prompt = "Playground script name: " }, launch)
  end
end

return {
  "stevearc/overseer.nvim",
  cmd = { "OverseerRun", "OverseerToggle", "OverseerOpen", "OverseerShell" },
  opts = {},
  keys = {
    { "<leader>jr", "<cmd>OverseerRun<CR>", desc = "Run task" },
    { "<leader>jt", "<cmd>OverseerToggle<CR>", desc = "Toggle task list" },
    { "<leader>js", ":OverseerShell ", desc = "Run shell task" },
    { "<leader>jp", run_playground, desc = "Run playground script" },
  },
}
