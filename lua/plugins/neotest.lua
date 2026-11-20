
return {
  "nvim-neotest/neotest",

  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-neotest/neotest-jest",
  },

  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-jest")({
          jestCommand = "yarn jest",
          env = { CI = "true" },

          cwd = function(file)
            return vim.fs.root(file, {
              "jest.config.ts",
              "jest.config.js",
              "jest.config.cjs",
              "jest.config.mjs",
            }) or vim.fn.getcwd()
          end,

          jestConfigFile = function(file)
            return vim.fs.find({
              "jest.config.ts",
              "jest.config.js",
              "jest.config.cjs",
              "jest.config.mjs",
            }, {
              upward = true,
              path = vim.fs.dirname(file),
            })[1]
          end,
        }),
      },

      output = {
        open_on_run = false,
      },
    })
  end,

  keys = {
    {
      "<leader>td",
      function()
        require("dap") -- load the debugger configuration before running the test
        require("neotest").run.run({ strategy = "dap", extra_args = { "--runInBand" } })
      end,
      desc = "Debug nearest Jest test",
    },
    {
      "<leader>tr",
      function()
        require("neotest").run.run()
      end,
      desc = "Run nearest test",
    },
    {
      "<leader>tf",
      function()
        require("neotest").run.run(
          vim.fn.expand("%:p")
        )
      end,
      desc = "Run current test file",
    },
    {
      "<leader>ta",
      function()
        require("neotest").run.run(vim.fn.getcwd())
      end,
      desc = "Run all tests",
    },
    {
      "<leader>tl",
      function()
        require("neotest").run.run_last()
      end,
      desc = "Run last test again",
    },
    {
      "<leader>ts",
      function()
        require("neotest").summary.toggle()
      end,
      desc = "Toggle test summary",
    },
    {
      "<leader>tu",
      function()
        require("neotest").output.open({
          enter = true,
        })
      end,
      desc = "Show test output",
    },
    {
      "<leader>tO",
      function()
        require("neotest").output_panel.toggle()
      end,
      desc = "Toggle test output panel",
    },
    {
      "<leader>tx",
      function()
        require("neotest").run.stop()
      end,
      desc = "Stop test",
    },
  },
}

