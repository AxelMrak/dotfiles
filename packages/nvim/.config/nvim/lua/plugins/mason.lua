return {
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    build = ":MasonUpdate",
    opts = {
      ensure_installed = {
        -- LSP servers
        "typescript-language-server",
        "vtsls",
        "eslint-lsp",
        "lua-language-server",
        "html-lsp",
        "css-lsp",
        "tailwindcss-language-server",
        "json-lsp",
        "yaml-language-server",
        "prisma-language-server",
        "bash-language-server",
        "dockerfile-language-server",
        "docker-compose-language-service",
        "marksman",
        "intelephense",
        "sqlls",

        -- Formatters
        "prettierd",
        "stylua",
        "sql-formatter",
        "pint",
        "shfmt",
        "black",
        "isort",

        -- Linters
        "eslint_d",
        "phpcs",
        "shellcheck",
        "hadolint",
        "yamllint",
        "markdownlint-cli2",
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      mr:on("package:install:success", function()
        vim.defer_fn(function()
          -- trigger FileType event to possibly load this newly installed LSP server
          require("lazy.core.handler.event").trigger({
            event = "FileType",
            buf = vim.api.nvim_get_current_buf(),
          })
        end, 100)
      end)

      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end

      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "mason.nvim" },
    opts = {
      handlers = {},
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason.nvim" },
    opts = {
      auto_update = true,
      run_on_start = true,
      start_delay = 3000,
      debounce_hours = 5,
    },
  },
}
