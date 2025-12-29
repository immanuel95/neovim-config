local o = vim.o

vim.g.mapleader = " "

o.laststatus = 3
o.showmode = false
o.winborder = "rounded"

o.clipboard = "unnamedplus"

o.formatexpr = "v:lua.require'conform'.formatexpr()"

-- Indenting
o.expandtab = true
o.shiftwidth = 2
o.smartindent = true
o.tabstop = 2
o.softtabstop = 2

vim.opt.fillchars = { eob = " " }
o.ignorecase = true
o.smartcase = true
o.mouse = "a"

o.number = true

o.signcolumn = "yes"
o.splitbelow = true
o.splitright = true
o.termguicolors = true
o.timeoutlen = 400
o.undofile = true
o.cursorline = true

local opt = vim.opt
opt.guicursor = {
  "n-v-c:block-Cursor",
  "i-ci-ve:ver25-Cursor",
  "r-cr:hor20-Cursor",
  "n-v-c-i-ci-ve-r-cr:blinkon500-blinkoff500",
}

local api = vim.api
api.nvim_set_hl(0, "YankHighlight", { bg = "#df8e1d", fg = "NONE" })

-- add binaries installed by mason.nvim to path
local is_windows = vim.loop.os_uname().sysname == "Windows_NT"
vim.env.PATH = vim.env.PATH .. (is_windows and ";" or ":") .. vim.fn.stdpath "data" .. "/mason/bin"

vim.api.nvim_set_hl(0, "IndentLine", { link = "Comment" })
