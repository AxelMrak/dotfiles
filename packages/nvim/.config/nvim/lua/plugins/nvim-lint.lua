return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPost", "BufNewFile", "InsertLeave", "BufWritePost" },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      vue = { "eslint_d" },
      svelte = { "eslint_d" },
      astro = { "eslint_d" },
      php = { "phpcs" },
      sh = { "shellcheck" },
      bash = { "shellcheck" },
      dockerfile = { "hadolint" },
      yaml = { "yamllint" },
    }

    local function strlist(t)
      local out = {}
      for _, v in ipairs(t) do
        if v ~= nil then
          out[#out + 1] = tostring(v)
        end
      end
      return out
    end

    local eslint = lint.linters.eslint_d
    if eslint then
      eslint.stdin = true
      eslint.ignore_exitcode = true
      eslint.args = function(ctx)
        return strlist({
          "--format",
          "json",
          "--stdin",
          "--stdin-filename",
          ctx.filename,
        })
      end
    end

    local phpcs = lint.linters.phpcs
    if phpcs then
      phpcs.stdin = true
      phpcs.args = function(ctx)
        local standard = vim.env.PHPCS_STANDARD or (ctx.root and (ctx.root .. "/phpcs.xml")) or "PSR12"
        return strlist({
          "--standard=" .. standard,
          "--report=json",
          "-q",
          "-", -- stdin
        })
      end
    end

    local shellcheck = lint.linters.shellcheck
    if shellcheck then
      shellcheck.stdin = true
      shellcheck.args = function(_)
        return { "--format", "json", "--external-sources", "-" }
      end
    end

    local hadolint = lint.linters.hadolint
    if hadolint then
      hadolint.stdin = true
      hadolint.args = function(_)
        return { "--format", "json", "-" }
      end
    end

    local yamllint = lint.linters.yamllint
    if yamllint then
      yamllint.stdin = true
      yamllint.args = function(_)
        return { "-f", "parsable", "-" }
      end
    end

    -- Auto lint
    local grp = vim.api.nvim_create_augroup("AxelLint", { clear = true })
    vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile", "InsertLeave", "BufWritePost" }, {
      group = grp,
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}
