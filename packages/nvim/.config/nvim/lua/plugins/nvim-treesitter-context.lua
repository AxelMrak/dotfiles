return {
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      enable = true, -- Enable this plugin (can be toggled later)
      max_lines = 2, -- Maximum lines to show for context
      trim_scope = "outer", -- Discard outer context if max_lines is exceeded
      mode = "cursor", -- Calculate context based on cursor position
      separator = "-", -- Separator between context and content
      zindex = 20, -- Z-index for the context window
    },
    config = function(_, opts)
      require("treesitter-context").setup(opts)

      -- Keybinding to toggle context display
      vim.keymap.set("n", "<leader>tc", "<CMD>TSContextToggle<CR>", { desc = "Toggle Treesitter Context" })
    end,
  },
}
