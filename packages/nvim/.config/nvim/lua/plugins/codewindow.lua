return {
  {
    "gorbit99/codewindow.nvim",
    config = function()
      local codewindow = require("codewindow")
      codewindow.setup({
        auto_enable = false,
        exclude_filetypes = { "NvimTree", "packer" },
        use_treesitter = true,
        use_lsp = true,
        use_git = true,
        minimap_width = 15,
      })
      codewindow.apply_default_keybinds()
      vim.keymap.set("n", "<leader>m", codewindow.toggle_minimap, { desc = "Toggle Minimap" })
    end,
  },
}
