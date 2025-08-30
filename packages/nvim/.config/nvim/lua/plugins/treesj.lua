return {
  {
    "Wansmer/treesj",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = { use_default_keymaps = false, max_join_length = 120 },
    keys = {
      { "<leader>cj", function() require("treesj").toggle() end, desc = "Split/Join toggle" },
      { "<leader>cs", function() require("treesj").split() end, desc = "Split node" },
      { "<leader>cm", function() require("treesj").join() end, desc = "Join node" },
    },
  },
}

