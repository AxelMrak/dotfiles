return {
  {
    "yioneko/nvim-vtsls",
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    keys = {
      { "<leader>to", ":VtslsOrganizeImports<cr>", desc = "TS Organize Imports" },
      { "<leader>tr", ":VtslsRenameFile<cr>", desc = "TS Rename File" },
      { "<leader>tu", ":VtslsRemoveUnused<cr>", desc = "TS Remove Unused" },
    },
  },
}
