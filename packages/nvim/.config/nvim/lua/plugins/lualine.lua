return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- Optional: for file icons
    opts = {
      options = {
        theme = "ayu_dark", -- Automatically adjust theme based on colorscheme
        globalstatus = true, -- Use a global statusline
        icons_enabled = true, -- Enable icons
        component_separators = { left = "|", right = "|" },
        section_separators = { left = " ", right = " " },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { "filename" },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = { "lsp_status" },
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      extensions = { "fugitive", "nvim-tree", "quickfix" },
    },
  },
}
