-- lua/plugins/which-key.lua
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    plugins = {
      marks = true,
      registers = true,
      spelling = { enabled = true, suggestions = 20 },
      presets = { operators = true, motions = true, text_objects = true, windows = true, nav = true, z = true, g = true },
    },
    icons = {
      breadcrumb = "»",
      separator = "➜",
      group = "+",
    },
    win = { border = "rounded", padding = { 1, 2, 1, 2 } },
    layout = { height = { min = 4, max = 25 }, width = { min = 20, max = 50 }, spacing = 6, align = "left" },
    show_help = true,
    show_keys = true,
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)

    local mappings = {
      { "<leader>o", group = "Tasks" },
      { "<leader>a", group = "AI" },
      { "<leader>h", group = "Harpoon" },
      { "<leader>l", group = "LSP" },

      { "<leader>uw", function() vim.opt.wrap = not vim.wo.wrap end, desc = "Toggle wrap" },
      { "<leader>un", function() vim.wo.number = not vim.wo.number; vim.wo.relativenumber = vim.wo.number and vim.wo.relativenumber or false end, desc = "Toggle line numbers" },
      { "<leader>uv", function()
          local cfg = vim.diagnostic.config()
          local vt = cfg.virtual_text
          local enable
          if vt == false then
            enable = true
          elseif type(vt) == "table" and vt.enabled ~= nil then
            enable = not vt.enabled
          else
            enable = not vt
          end
          vim.diagnostic.config({ virtual_text = enable })
        end, desc = "Toggle diagnostics virtual text" },
    }

    wk.add(mappings, { mode = "n" })
    vim.keymap.set("n", "<leader>?", function() require("which-key").show() end, { desc = "Which-key help" })
  end,
}
