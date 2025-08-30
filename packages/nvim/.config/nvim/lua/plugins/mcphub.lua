return {
  {
    "ravitemer/mcphub.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim", -- Required for async operations
    },
    build = "npm install -g mcp-hub@latest", -- Installs core MCP Hub server
    config = function()
      require("mcphub").setup({
        port = 3004, -- Default hub port
        config = vim.fn.expand("~/.config/nvim/mcpservers.json"), -- Absolute path required
        log = {
          level = vim.log.levels.WARN, -- DEBUG, INFO, WARN, ERROR
          to_file = true, -- Creates ~/.local/state/nvim/mcphub.log
        },
        on_ready = function()
          vim.notify("MCP Hub is online!")
        end,
        extensions = {
          avante = {
            make_slash_commands = true, -- make /slash commands from MCP server prompts
          },
        },
      })
    end,
  },
}
