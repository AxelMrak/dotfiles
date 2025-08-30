return {
  {
    "tiesen243/vercel.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("vercel").setup({
        theme = "dark",
        transparent = false,
        italics = {
          comments = true,
          keywords = true,
          functions = true,
          strings = true,
          variables = true,
          bufferline = false,
        },
        overrides = {
          Normal = { bg = "#000000" },
          NormalFloat = { bg = "#000000" },
          FloatBorder = { bg = "#000000", fg = "#30363d" },
          CursorLine = { bg = "#111111" },
          CursorLineNr = { fg = "#00eaff", bg = "#111111" },
          SignColumn = { bg = "#000000" },
          StatusLine = { bg = "#000000", fg = "#00eaff" },
          StatusLineNC = { bg = "#000000", fg = "#333333" },
          TabLine = { bg = "#000000", fg = "#ffffff" },
          Visual = { bg = "#009dff", fg = "#000000" },
          Search = { bg = "#ffaa00", fg = "#000000" },
          Error = { fg = "#ff3b30", bg = "#000000" },
          WarningMsg = { fg = "#ffaa00", bg = "#000000" },
          DiffAdd = { bg = "#003300" },
          DiffDelete = { bg = "#330000" },
        },
      })
      vim.cmd.colorscheme("vercel")
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "vercel",
    },
  },
}
