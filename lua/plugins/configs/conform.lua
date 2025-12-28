return {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettierd" },
    html = { "prettierd" },
    python = { "ruff_fix, ruff_format, ruff_organize_imports" },
    svelte = { "prettierd" },
    javascript = { "prettierd" },
    javascriptreact = { "prettierd" },
    typescript = { "prettierd" },
    typescriptreact = { "prettierd" },
    go = { "goimports", "gofumpt" },
    -- markdown = { "markdownlint-cli2", "markdown-toc" },
    json = { "prettierd" },
    yaml = { "prettierd" },
    yml = { "prettierd" },
  },

  format_on_save = {
    timeout_ms = 1000,
    lsp_fallback = true,
  },
}
