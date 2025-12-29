local api = vim.api

api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank { higroup = "YankHighlight", timeout = 300 }
  end,
})

api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = { "*.csv", "*.md" },
  callback = function()
    vim.wo.wrap = true
  end,
})
