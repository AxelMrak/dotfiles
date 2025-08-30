return {
  {
    "gbprod/yanky.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    opts = {
      highlight = { on_put = true, on_yank = true, timer = 200 },
      ring = { history_length = 100, storage = "memory" },
      system_clipboard = { sync_with_ring = true },
    },
    keys = {
      { "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" } },
      { "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" } },
      { "gp", "<Plug>(YankyGPutAfter)", mode = { "n", "x" } },
      { "gP", "<Plug>(YankyGPutBefore)", mode = { "n", "x" } },
      { "y", "<Plug>(YankyYank)", mode = { "n", "x" } },
      { "<leader>yy", function() require("telescope").extensions.yank_history.yank_history() end, desc = "Yank history" },
      { "<leader>y]", "<Plug>(YankyCycleForward)", desc = "Yank ring next" },
      { "<leader>y[", "<Plug>(YankyCycleBackward)", desc = "Yank ring prev" },
    },
    config = function(_, opts)
      require("yanky").setup(opts)
    end,
  },
}

