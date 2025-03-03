return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "zig" })
      else
        opts.ensure_installed = { "zig" }
      end
    end,
  },
  {
    "ziglang/zig.vim",
    ft = "zig",
  },
  {
    "mfussenegger/nvim-dap",
    opts = function()
      local dap = require("dap")
      dap.configurations["zig"] = {
        {
          type = "codelldb",
          request = "launch",
          name = "Run Zig program",
          program = function()
            vim.cmd("make")
            local command = "fd . -t x zig-out/bin/"
            local bin_location = io.popen(command, "r")

            if bin_location ~= nil then
              return vim.fn.getcwd() .. "/" .. bin_location:read("*a"):gsub("[\n\r]", "")
            else
              return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            end
          end,
          args = function()
            if vim.g.zig_dap_argv ~= nil then
              return vim.g.zig_dap_argv
            end

            local argv = {}
            local arg = vim.fn.input(string.format("Arguments: "))

            for a in string.gmatch(arg, "%S+") do
              table.insert(argv, a)
            end

            vim.g.zig_dap_argv = argv

            return argv
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
        {
          type = "codelldb",
          request = "launch",
          name = "Run Zig program (new args)",
          program = function()
            vim.cmd("make")
            local command = "fd . -t x zig-out/bin/"
            local bin_location = io.popen(command, "r")

            if bin_location ~= nil then
              return vim.fn.getcwd() .. "/" .. bin_location:read("*a"):gsub("[\n\r]", "")
            else
              return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            end
          end,
          args = function()
            local argv = {}
            local arg = vim.fn.input(string.format("New Arguments: "))

            for a in string.gmatch(arg, "%S+") do
              table.insert(argv, a)
            end

            vim.g.zig_dap_argv = argv

            return argv
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
        {
          type = "codelldb",
          request = "attach",
          name = "Attach to process",
          pid = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
        },
      }
    end,
  },
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "lawrence-laz/neotest-zig",
    },
    opts = {
      adapters = {
        ["neotest-zig"] = {},
      },
    },
  },
  {
    "williamboman/mason.nvim",
    optional = true,
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "zls", "codelldb" })
      end
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        zls = {
          -- enabled = false,
          -- enable_inlay_hints = false,
          warn_style = true,
          semantic_tokens = "full",
        },
      },
      -- setup = {
      --   zls = function()
      --     return true
      --   end,
      -- },
    },
  },
}
