return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "mason-org/mason.nvim",
  },
  config = function()
    local dap = require("dap")
    local ui = require("dapui")
    ui.setup()

    local function adapter_binary(name)
      local path = vim.fn.stdpath("data") .. "/mason/bin/" .. name
      return vim.fn.executable(path) == 1 and path or name
    end

    dap.adapters["pwa-node"] = {
      type = "server",
      host = "127.0.0.1",
      port = "${port}",
      executable = {
        command = adapter_binary("js-debug-adapter"),
        args = { "${port}" },
      },
    }
    local function js_cwd()
      return vim.fs.root(0, "package.json") or vim.fn.getcwd()
    end
    local node_configs = {
      {
        name = "Node: attach to inspector (9229)",
        type = "pwa-node",
        request = "attach",
        address = "127.0.0.1",
        port = 9229,
        cwd = js_cwd,
        sourceMaps = true,
        skipFiles = { "<node_internals>/**" },
      },
      {
        name = "Node: attach to process",
        type = "pwa-node",
        request = "attach",
        processId = require("dap.utils").pick_process,
        cwd = js_cwd,
        sourceMaps = true,
      },
    }
    for _, ft in ipairs({ "javascript", "javascriptreact", "typescript", "typescriptreact" }) do
      dap.configurations[ft] = vim.deepcopy(node_configs)
    end
    -- Direct Node launch is for JavaScript; TS projects usually need their own runtime.
    table.insert(dap.configurations.javascript, {
      name = "Node: launch current JS file",
      type = "pwa-node",
      request = "launch",
      program = "${file}",
      cwd = js_cwd,
      console = "integratedTerminal",
    })

    dap.adapters.codelldb = {
      type = "server",
      host = "127.0.0.1",
      port = "${port}",
      executable = { command = adapter_binary("codelldb"), args = { "--port", "${port}" } },
    }
    local native_configs = {
      {
        name = "LLDB: launch executable",
        type = "codelldb",
        request = "launch",
        program = function()
          local path = vim.fn.input("Executable: ", vim.fn.getcwd() .. "/", "file")
          if path == "" then return dap.ABORT end
          return vim.fn.fnamemodify(path, ":p")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
      },
    }
    dap.configurations.c = vim.deepcopy(native_configs)
    dap.configurations.cpp = vim.deepcopy(native_configs)

    dap.listeners.after.event_initialized["dev_ui"] = function() ui.open() end
    dap.listeners.before.event_terminated["dev_ui"] = function() ui.close() end
    dap.listeners.before.event_exited["dev_ui"] = function() ui.close() end
  end,
  keys = {
    { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle breakpoint" },
    { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "Conditional breakpoint" },
    { "<leader>dc", function() require("dap").continue() end, desc = "Start / continue debugger" },
    { "<leader>di", function() require("dap").step_into() end, desc = "Step into" },
    { "<leader>do", function() require("dap").step_over() end, desc = "Step over" },
    { "<leader>dO", function() require("dap").step_out() end, desc = "Step out" },
    { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate debugger" },
    { "<leader>du", function() require("dapui").toggle() end, desc = "Toggle debugger UI" },
    { "<leader>de", function() require("dapui").eval() end, mode = { "n", "x" }, desc = "Evaluate expression" },
    { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle debug REPL" },
  },
}
