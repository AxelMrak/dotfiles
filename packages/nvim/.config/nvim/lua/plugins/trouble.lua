return {
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- Optional dependency for file icons
    opts = {
      use_diagnostic_signs = true, -- Use the signs defined in your LSP client
      auto_open = false, -- Prevent Trouble from opening automatically
      auto_close = true, -- Automatically close Trouble when no diagnostics are present
      auto_preview = true, -- Enable automatic preview of the location
      signs = {
        error = "",
        warning = "",
        hint = "",
        information = "",
      },
    },
    config = function(_, opts)
      require("trouble").setup(opts)

      -- Keybindings for Trouble
      vim.keymap.set(
        "n",
        "<leader>xx",
        "<cmd>TroubleToggle document_diagnostics<cr>",
        { desc = "Toggle Document Diagnostics (Trouble)" }
      )
      vim.keymap.set(
        "n",
        "<leader>xX",
        "<cmd>TroubleToggle workspace_diagnostics<cr>",
        { desc = "Toggle Workspace Diagnostics (Trouble)" }
      )
      vim.keymap.set("n", "<leader>xL", "<cmd>TroubleToggle loclist<cr>", { desc = "Toggle Location List (Trouble)" })
      vim.keymap.set("n", "<leader>xQ", "<cmd>TroubleToggle quickfix<cr>", { desc = "Toggle Quickfix List (Trouble)" })
    end,
  },
}
