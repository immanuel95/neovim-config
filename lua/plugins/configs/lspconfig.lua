--------------------------------------------------------------------------------
-- 1. DIAGNOSTICS CONFIGURATION
--------------------------------------------------------------------------------
vim.diagnostic.config {
  virtual_text = {
    prefix = "",
    source = "if_many",
    spacing = 2,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅙",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.HINT] = "󰌵",
      [vim.diagnostic.severity.INFO] = "󰋼",
    },
  },
  underline = true,
  float = { border = "single" },
}

--------------------------------------------------------------------------------
-- 2. CAPABILITIES
--------------------------------------------------------------------------------
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

vim.lsp.config("*", { capabilities = capabilities })

--------------------------------------------------------------------------------
-- 3. SERVER CONFIGURATIONS
--------------------------------------------------------------------------------
local servers = {
  html = {},
  cssls = {},
  svelte = {},

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
        suggest = { completeFunctionCalls = true },
        inlayHints = {
          enumMemberValues = { enabled = false },
          functionLikeReturnTypes = { enabled = false },
          parameterNames = { enabled = false },
          parameterTypes = { enabled = false },
          propertyDeclarationTypes = { enabled = false },
          variableTypes = { enabled = false },
        },
      },
    },
  },

  tailwindcss = {
    filetypes_exclude = { "markdown" },
  },

  pyright = {
    settings = {
      python = { analysis = { ignore = { "*" } } },
      pyright = { disableOrganizeImports = true },
    },
  },

  ruff = {
    init_options = {
      settings = {
        logLevel = "error",
        format = { enable = true },
        organizeImports = true,
        fixAll = true,
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
        analyses = { unusedparams = true },
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

for name, opts in pairs(servers) do
  vim.lsp.config(name, opts)
  vim.lsp.enable(name)
end

--------------------------------------------------------------------------------
-- 4. ATTACHMENT LOGIC (Keymaps & Client mods)
--------------------------------------------------------------------------------
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

    local opts = { buffer = bufnr, desc = "LSP" }
    local map = vim.keymap.set

    map("n", "gD", vim.lsp.buf.declaration, opts)
    map("n", "gd", vim.lsp.buf.definition, opts)
    map("n", "<space>D", vim.lsp.buf.type_definition, opts)
    map("n", "<space>rn", vim.lsp.buf.rename, opts)
    map("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
    map("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
    map("n", "<space>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)

    if client and client.name == "ruff" then
      -- Disable pyright hover in favor of Pyright
      client.server_capabilities.hoverProvider = false
    end
  end,
})
