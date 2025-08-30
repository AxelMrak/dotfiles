return {
  {
    "iamcco/markdown-preview.nvim",
    setup = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
}
