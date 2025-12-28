local M = {}

M.opts = {
  completions = { blink = { enabled = true } },
  -- render_modes = { "n", "c", "t" },
  render_modes = true,
  win_options = {
    conceallevel = { default = vim.o.conceallevel, rendered = 3 },
    concealcursor = { default = vim.o.concealcursor, rendered = "" },
  },
  bullet = {
    enabled = true,
    icons = { "●", "○", "◆", "◇" },
    ordered_icons = function(ctx)
      local value = vim.trim(ctx.value)
      local index = tonumber(value:sub(1, #value - 1))
      return ("%d."):format(index > 1 and index or ctx.index)
    end,
    left_pad = 4,
    right_pad = 0,
    highlight = "RenderMarkdownBullet",
    scope_highlight = {},
  },
  heading = {
    enabled = true,
    render_modes = false,
    atx = true,
    setext = true,
    sign = true,
    icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
    position = "overlay",
    signs = { "󰫎 " },
    width = "full",
    left_margin = 0,
    left_pad = 0,
    right_pad = 0,
    min_width = 0,
    border = false,
    border_virtual = false,
    border_prefix = false,
    above = "▄",
    below = "▀",
    backgrounds = {
      "RenderMarkdownH1Bg",
      "RenderMarkdownH2Bg",
      "RenderMarkdownH3Bg",
      "RenderMarkdownH4Bg",
      "RenderMarkdownH5Bg",
      "RenderMarkdownH6Bg",
    },
    foregrounds = {
      "RenderMarkdownH1",
      "RenderMarkdownH2",
      "RenderMarkdownH3",
      "RenderMarkdownH4",
      "RenderMarkdownH5",
      "RenderMarkdownH6",
    },
    custom = {},
  },
  indent = { enabled = false },
}

return M
