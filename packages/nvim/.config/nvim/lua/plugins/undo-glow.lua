return {
  {
    "y3owk1n/undo-glow.nvim",
    version = "*",
    opts = {
      animation = {
        enabled = true, -- Enable animations
        duration = 300, -- Animation duration in milliseconds
        animation_type = "fade", -- Type of animation: 'fade', 'slide', 'pulse', etc.
      },
      highlights = {
        undo = { hl_color = { bg = "#FF5555" } }, -- Background color for undo operations
        redo = { hl_color = { bg = "#50FA7B" } }, -- Background color for redo operations
        yank = { hl_color = { bg = "#F1FA8C" } }, -- Background color for yank operations
        paste = { hl_color = { bg = "#BD93F9" } }, -- Background color for paste operations
      },
    },
    config = function(_, opts)
      require("undo-glow").setup(opts)

      -- Key mappings for undo and redo with highlight
      vim.keymap.set("n", "u", function()
        require("undo-glow").undo()
      end, { noremap = true, desc = "Undo with highlight" })

      vim.keymap.set("n", "<C-r>", function()
        require("undo-glow").redo()
      end, { noremap = true, desc = "Redo with highlight" })
    end,
  },
}
