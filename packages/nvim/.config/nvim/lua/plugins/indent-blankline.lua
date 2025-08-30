return {
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      indent = {
        highlight = {
          "SoftRed",
          "SoftYellow",
          "SoftBlue",
          "SoftOrange",
          "SoftGreen",
          "SoftViolet",
          "SoftCyan",
        },
      },
    },
    config = function(_, opts)
      local hooks = require("ibl.hooks")
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        local colors = {
          SoftRed = "#7f4c4c", -- dark desaturated red
          SoftYellow = "#7f7040", -- soft mustard
          SoftBlue = "#4c5a7f", -- grayish blue
          SoftOrange = "#7f5a3a", -- burnt orange
          SoftGreen = "#4c7f5a", -- muted green
          SoftViolet = "#6a4c7f", -- opaque violet
          SoftCyan = "#407f7a", -- grayish cyan
        }

        for group, color in pairs(colors) do
          vim.api.nvim_set_hl(0, group, { fg = color })
        end
      end)

      require("ibl").setup(opts)
    end,
  },
}
