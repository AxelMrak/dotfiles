return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = { "zbirenbaum/copilot.lua" },
    cmd = { "CopilotChat", "CopilotChatCommit" },
    opts = {},
    keys = {
      { "<leader>gc", "<cmd>CopilotChatCommit<cr>", desc = "AI Commit (CopilotChat)" },
    },
  },
}

