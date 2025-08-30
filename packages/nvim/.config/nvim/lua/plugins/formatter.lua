-- lua/plugins/formatter.lua
return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        typescript = { "prettierd" },
        typescriptreact = { "prettierd" },
        javascript = { "prettierd" },
        javascriptreact = { "prettierd" },
        css = { "prettierd" },
        html = { "prettierd" },
        json = { "prettierd" },
        yaml = { "prettierd" },
        markdown = { "prettierd" },
        php = { "pint" },
        python = { "isort", "black" },
        sh = { "shfmt" },
      },
      -- LazyVim manages format-on-save. Use :LazyExtras to adjust
      -- or set vim.g.autoformat = false to disable globally.
    },
  },
}
