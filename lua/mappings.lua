local map = vim.keymap.set

-- general mappings
map("n", "<C-s>", "<cmd> w <CR>")
map("i", "jk", "<ESC>")
map("n", ";", ":", { desc = "CMD enter command mode" })

-- move
map("i", "<C-h>", "<Left>", { desc = "move left" })
map("i", "<C-l>", "<Right>", { desc = "move right" })
map("i", "<C-j>", "<Down>", { desc = "move down" })
map("i", "<C-k>", "<Up>", { desc = "move up" })

-- switch windows
map("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
map("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
map("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
map("n", "<C-k>", "<C-w>k", { desc = "switch window up" })

-- copy lines
map(
  "v",
  "<leader>J",
  ":t '><CR>gv=gv",
  { noremap = true, silent = true, desc = "Copy selected lines below in visual mode" }
)
map(
  "v",
  "<leader>K",
  ":t '< -1<CR>gv=gv",
  { noremap = true, silent = true, desc = "Copy selected lines top in visual mode" }
)

-- terminal
map("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })
map("n", "<leader>tt", ":terminal<CR>", { desc = "Open terminal" })

-- mini.nvim
map("n", "<C-n>", function()
  require("mini.files").open(vim.api.nvim_buf_get_name(0), false)
end, { desc = "Open mini files" })
map("n", "<leader>ff", ":Pick files<CR>")
map("n", "<leader>fw", ":Pick grep live<CR>")
map("n", "<leader>n", function()
  require("mini.notify").show_history()
end, { desc = "Notify history" })

-- buffers
map("n", "H", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev Buffer" })
map("n", "L", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })
map("n", "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", { desc = "Close Other Buffers" })
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete Current Buffer" })

-- windows management
map(
  "n",
  "<A-Right>",
  ":vertical resize -10<CR>",
  { noremap = true, silent = true, desc = "Resize vertical split (widen right)" }
)
map(
  "n",
  "<A-Left>",
  ":vertical resize +10<CR>",
  { noremap = true, silent = true, desc = "Resize vertical split (narrow left)" }
)
map(
  "n",
  "<A-Up>",
  ":resize +5<CR>",
  { noremap = true, silent = true, desc = "Resize horizontal split (increase height)" }
)
map(
  "n",
  "<A-Down>",
  ":resize -5<CR>",
  { noremap = true, silent = true, desc = "Resize horizontal split (decrease height)" }
)
map("n", "<leader>wh", ":split<CR>", { noremap = true, silent = true, desc = "Split horizontal" })
map("n", "<leader>wv", ":vsplit<CR>", { noremap = true, silent = true, desc = "Split vertical" })
map("n", "<leader>wch", ":new<CR>", { noremap = true, silent = true, desc = "Split horizontal new buffer" })
map("n", "<leader>wcv", ":vnew<CR>", { noremap = true, silent = true, desc = "Split vertical new buffer" })
map("n", "<leader>wd", ":close<CR>", { noremap = true, silent = true, desc = "Close current window" })
map("n", "<leader>wo", ":only<CR>", { noremap = true, silent = true, desc = "Close all other windows" })

-- conform
map("n", "<leader>cF", function()
  require("conform").format { formatters = { "injected" }, timout_ms = 3000 }
end, { desc = "Format injected langs" })

-- misc
map("n", "<C-e>", "10<C-e>", { desc = "Scroll down 10 lines" })
map("n", "<C-y>", "10<C-y>", { desc = "Scroll up 10 lines" })
map("n", "<leader>L", ":Lazy<CR>", { noremap = true, silent = true, desc = "Lazy Command" })
map("n", "<C-s>", ":w<CR>", { noremap = true, silent = true, desc = "Save" })
map("i", "<C-c>", "<Esc>", { noremap = true, desc = "Exit Insert mode" })

-- iron.nvim
map("n", "<leader>rs", "<cmd>IronRepl<cr>", { noremap = true, desc = "Open REPL" })
map("n", "<leader>rr", "<cmd>IronRestart<cr>", { noremap = true, desc = "Restart REPL" })
map("n", "<leader>rf", "<cmd>IronFocus<cr>", { noremap = true, desc = "Focus REPL" })
map("n", "<leader>rh", "<cmd>IronHide<cr>", { noremap = true, desc = "Hide REPL" })
