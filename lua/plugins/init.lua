return {
  { "lewis6991/gitsigns.nvim", opts = {} },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "mocha",
      transparent_background = true,
      float = {
        transparent = false,
        solid = false,
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    opts = function()
      require "plugins.configs.treesitter"
    end,
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  {
    "akinsho/bufferline.nvim",
    opts = require "plugins.configs.bufferline",
  },

  {
    "saghen/blink.cmp",
    version = "1.*",
    event = "InsertEnter",
    enabled = true,
    dependencies = {
      "echasnovski/mini.nvim",
    },
    opts = function()
      return require "plugins.configs.blink"
    end,
  },

  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    cmd = { "Mason", "MasonInstall" },
    opts = {},
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
    end,
  },

  {
    "stevearc/conform.nvim",
    opts = require "plugins.configs.conform",
  },

  {
    "echasnovski/mini.nvim",
    version = "*",
    config = function()
      require("plugins.configs.mini").setup()
    end,
  },

  {
    "MagicDuck/grug-far.nvim",
    opts = { headerMaxWidth = 80 },
    cmd = "GrugFar",
    keys = {
      {
        "<leader>sr",
        function()
          local grug = require "grug-far"
          local ext = vim.bo.buftype == "" and vim.fn.expand "%:e"
          grug.open {
            transient = true,
            prefills = {
              filesFilter = ext and ext ~= "" and "*." .. ext or nil,
            },
          }
        end,
        mode = { "n", "v" },
        desc = "Search and Replace",
      },
    },
  },

  {
    "mfussenegger/nvim-lint",
    events = { "BufWritePost", "BufReadPost", "InsertLeave" },
    linters_by_ft = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      markdown = { "vale" },
      go = { "gofumpt" },
      python = { "ruff" },
    },
  },

  {
    "windwp/nvim-ts-autotag",
    ft = { "svelte", "typescriptreact", "html" },
    opts = {
      enable_close = true,
      enable_rename = true,
      enable_close_on_slash = true,
    },
  },

  {
    "Vigemus/iron.nvim",
    enabled = false,
    ft = { "python" },
    config = function()
      require "configs.iron"
    end,
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" },
    opts = function()
      return require("plugins.configs.render-markdown").opts
    end,
  },
}
