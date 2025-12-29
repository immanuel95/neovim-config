local M = {}

M.setup = function()
  local latex_patterns = { "latex/**/*.json", "**/latex.json" }
  local lang_patterns = {
    tex = latex_patterns,
    plaintex = latex_patterns,
    markdown_inline = { "markdown.json" },
  }
  local gen_loader = require("mini.snippets").gen_loader

  local mouse_scrolled = false
  for _, scroll in ipairs { "Up", "Down" } do
    local key = "<ScrollWheel" .. scroll .. ">"
    vim.keymap.set({ "", "i" }, key, function()
      mouse_scrolled = true
      return key
    end, { expr = true })
  end

  local animate = require "mini.animate"
  animate.setup {
    scroll = {
      timing = animate.gen_timing.linear { duration = 150, unit = "total" },
      subscroll = animate.gen_subscroll.equal {
        predicate = function(total_scroll)
          if mouse_scrolled then
            mouse_scrolled = false
            return false
          end
          return total_scroll > 1
        end,
      },
    },
    cursor = {
      enable = false,
    },
  }

  require("mini.jump2d").setup {
    allowed_windows = { not_current = true },
    allowed_lines = { blank = false },
    mappings = { start_jumping = "<leader><leader>" },
  }

  require("mini.surround").setup {
    mappings = {
      add = "gsa",
      delete = "gsd",
      find = "gsf",
      find_left = "gsF",
      highlight = "gsh",
      replace = "gsr",
      update_n_lines = "gsn",
      suffix_last = "l",
      suffix_next = "n",
    },
  }

  require("mini.snippets").setup {
    snippets = {
      gen_loader.from_lang { lang_patterns = lang_patterns },
    },
  }

  require("mini.pairs").setup {
    modes = { insert = true, command = true, terminal = false },
  }

  require("mini.indentscope").setup {
    symbol = "│",
    options = { try_as_border = true },
  }

  require("mini.files").setup {
    windows = {
      preview = true,
      width_focus = 30,
      width_preview = 60,
    },
    options = {
      use_as_default_explorer = true,
    },
  }

  require("mini.icons").setup()
  require("mini.icons").mock_nvim_web_devicons()
  require("mini.move").setup()
  require("mini.cursorword").setup()
  require("mini.cmdline").setup()
  require("mini.pick").setup()
  require("mini.statusline").setup()
  require("mini.notify").setup()
end

return M
