-- Use LspAttach autocommand to only map the following keys
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    local opts = { buffer = ev.buf }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set("n", "<space>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
  end,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

local servers = {
  lua_ls = {
    settings = {
      Lua = {
        runtime = { version = "LuaJIT" },
        workspace = {
          library = {
            vim.fn.expand "$VIMRUNTIME/lua",
            "${3rd}/luv/library",
          },
        },
      },
    },
  },
  html = {},
  cssls = {},
  vtsls = {
    filetypes = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
    },
    settings = {
      typescript = {
        updateImportsOnFileMove = { enabled = "always" },
        suggest = {
          completeFunctionCalls = true,
        },
        inlayHints = {
          enumMemberValues = { enabled = false },
          functionLikeReturnTypes = { enabled = false },
          parameterNames = { enabled = false },
          parameterTypes = { enabed = false },
          propertyDeclarationTypes = { enabled = false },
          variableTypes = { enabled = false },
        },
      },
    },
  },
  svelte = {},
  tailwindcss = {
    filetypes_exclude = { "markdown" },
  },
  pyright = {
    settings = {
      python = {
        analysis = {
          ignore = { "*" },
          -- typeCheckingMode = "strict",
          -- diagnosticsMode = "workspace",
        },
      },
      pyright = {
        disableOrganizeImports = true,
      },
    },
  },
  ruff = {
    init_options = {
      settings = {
        lineLength = 88,
        logLevel = "debug",
        exclude = { ".venv", "__pycache__", ".pytest_cache", ".ruff_cache" },
        lint = {
          select = { "E", "W", "F", "B", "I", "N", "D", "UP", "ANN", "S", "RUF", "TCH", "PTH", "DOC" },
          ignore = {
            "E501", -- Line length (handled by formatter)
            "ANN101", -- Missing type annotation for self (common in Python classes)
            "D203", -- Conflicts with D211 (docstring whitespace)
            "F401", -- Unused import (Pyright's is more robust)
          },
        },
      },
    },
  },
  gopls = {
    settings = {
      gopls = {
        usePlaceholders = false,
        gofumpt = true,
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          constantValues = true,
          functionTypeParameters = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
        analyses = {
          unusedparams = true,
        },
        staticcheck = true,
        codelenses = {
          generate = true,
          regenerate_cgo = true,
          run_govulncheck = true,
          test = true,
          tidy = true,
          upgrade_dependency = true,
          vendor = true,
        },
      },
    },
  },
}

local x = vim.diagnostic.severity

vim.diagnostic.config {
  virtual_text = { prefix = "" },
  signs = { text = { [x.ERROR] = "󰅙", [x.WARN] = "", [x.INFO] = "󰋼", [x.HINT] = "󰌵" } },
  underline = true,
  float = { border = "single" },
}

vim.lsp.config("*", { capabilities = capabilities })

-- vim.lsp.enable(servers)
for name, opts in pairs(servers) do
  vim.lsp.config(name, opts)
  vim.lsp.enable(name)
end
