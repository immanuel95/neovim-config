vim.api.nvim_create_user_command("MasonInstallAll", function()
  vim.cmd "MasonInstall css-lsp html-lsp lua-language-server vtsls eslint_d pyright svelte-language-server gopls goimports gofumpt tailwindcss-language-server ruff yaml-language-server stylua prettierd"
end, {})
