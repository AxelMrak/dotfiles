return {
  {
    "sindrets/diffview.nvim",
    dependencies = {
      { "nvim-tree/nvim-web-devicons", lazy = true },
    },
    keys = {
      {
        "<leader>dv",
        function()
          local lib = require("diffview.lib")
          if next(lib.views) == nil then
            vim.cmd("DiffviewOpen")
          else
            vim.cmd("DiffviewClose")
          end
        end,
        desc = "Diffview",
      },
    },
    config = function()
      require("diffview").setup({})
    end,
  },
}
