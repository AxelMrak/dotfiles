return {
  {
    "stevearc/overseer.nvim",
    cmd = { "OverseerToggle", "OverseerRun", "OverseerQuickAction", "OverseerRunCmd", "OverseerBuild" },
    opts = {},
    keys = {
      { "<leader>ot", "<cmd>OverseerToggle<cr>", desc = "Tasks: Toggle" },
      { "<leader>or", "<cmd>OverseerRun<cr>", desc = "Tasks: Run" },
      { "<leader>oo", "<cmd>OverseerRunCmd<cr>", desc = "Tasks: Run Cmd" },
      { "<leader>oa", "<cmd>OverseerQuickAction<cr>", desc = "Tasks: Quick Action" },
      { "<leader>ob", "<cmd>OverseerBuild<cr>", desc = "Tasks: Build" },
    },
  },
}

