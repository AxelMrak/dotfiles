return {
  {
    -- Official GitHub Copilot kept installed for commands, but disabled inline
    "github/copilot.vim",
    event = "InsertEnter",
    config = function()
      -- Disable inline suggestions from the Vim plugin to avoid conflicts
      vim.g.copilot_enabled = 0
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        -- Fast inline suggestions via copilot.lua
        suggestion = {
          enabled = true,
          auto_trigger = true,
          debounce = 0,
          keymap = { accept = false, accept_word = false, accept_line = false },
        },
        panel = { enabled = false },
      })

      -- Convenient keymaps for accepting inline suggestions
      local ok, sug = pcall(require, "copilot.suggestion")
      if ok then
        vim.keymap.set("i", "<C-y>", function()
          if sug.is_visible() then sug.accept() end
        end, { silent = true, desc = "Copilot Accept" })
        vim.keymap.set("i", "<M-]>", function()
          if sug.is_visible() then sug.next() else vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<M-]>", true, true, true), "n", false) end
        end, { silent = true, desc = "Copilot Next" })
        vim.keymap.set("i", "<M-[>", function()
          if sug.is_visible() then sug.prev() else vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<M-[>", true, true, true), "n", false) end
        end, { silent = true, desc = "Copilot Prev" })
        vim.keymap.set("i", "<C-]>", function()
          if sug.is_visible() then sug.dismiss() end
        end, { silent = true, desc = "Copilot Dismiss" })
      end
    end,
  },
  {
    -- Integrate Copilot into nvim-cmp menu
    "zbirenbaum/copilot-cmp",
    dependencies = { "zbirenbaum/copilot.lua", "hrsh7th/nvim-cmp" },
    event = "InsertEnter",
    enabled = false, -- use inline Copilot suggestions instead of CMP source
    config = function() end,
  },
}
