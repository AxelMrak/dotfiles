return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    {
      "L3MON4D3/LuaSnip",
      build = "make install_jsregexp",
      dependencies = {
        {
          "rafamadriz/friendly-snippets",
          config = function()
            local ok, loader = pcall(require, "luasnip.loaders.from_vscode")
            if ok then
              loader.lazy_load()
            end
          end,
        },
      },
    },
    "saadparwaiz1/cmp_luasnip",
  },
  config = function()
    local cmp = require("cmp")
    local has_luasnip, luasnip = pcall(require, "luasnip")
    local cop_ok, cop_sug = pcall(require, "copilot.suggestion")
    local copcmp_ok, copcmp = pcall(require, "copilot_cmp.comparators")
    local copcmp_src_ok = pcall(require, "copilot_cmp")

    local unpack = table.unpack or unpack

    local function expand_snippet(args)
      if has_luasnip then
        luasnip.lsp_expand(args.body)
      elseif vim.snippet and vim.snippet.expand then
        vim.snippet.expand(args.body)
      else
        vim.notify("No snippet engine available to expand LSP snippets", vim.log.levels.WARN)
      end
    end

    local function has_words_before()
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      if col == 0 then
        return false
      end
      local text = vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]
      return text:sub(col, col):match("%s") == nil
    end

    local function expand_or_jump()
      if has_luasnip and luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
        return true
      end
      return false
    end

    local function jumpable(dir)
      return has_luasnip and luasnip.jumpable(dir)
    end

    local primary_sources = {}
    -- Add Copilot CMP source only if available (we default to inline suggestions)
    if copcmp_src_ok then
      table.insert(primary_sources, { name = "copilot", group_index = 1, keyword_length = 1 })
    end
    -- Other sources in secondary group
    table.insert(primary_sources, { name = "nvim_lsp", group_index = 2 })
    if has_luasnip then
      table.insert(primary_sources, { name = "luasnip", group_index = 2 })
    end
    table.insert(primary_sources, { name = "path", group_index = 2 })
    table.insert(primary_sources, { name = "nvim_lsp_signature_help", group_index = 2 })

    local comparators = {}
    if copcmp_ok and copcmp and copcmp.prioritize then
      table.insert(comparators, copcmp.prioritize)
      if copcmp.score then
        table.insert(comparators, copcmp.score)
      end
    end
    vim.list_extend(comparators, {
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,
      cmp.config.compare.recently_used,
      cmp.config.compare.locality,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    })

    cmp.setup({
      snippet = { expand = expand_snippet },
      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping(function(fallback)
          local entry = cmp.get_selected_entry()
          if cmp.visible() and entry then
            cmp.confirm({ select = false })
            return
          end
          fallback()
        end, { "i", "s" }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          -- Prefer accepting Copilot inline suggestion when visible
          if cop_ok and cop_sug and cop_sug.is_visible() then
            cop_sug.accept()
            return
          end
          if cmp.visible() then
            cmp.select_next_item()
          elseif expand_or_jump() then
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
      completion = { keyword_length = 2, completeopt = "menu,menuone,noselect" },
      sources = cmp.config.sources(primary_sources, { { name = "buffer", keyword_length = 3 } }),
      formatting = {
        format = function(entry, vim_item)
          local icons = {
            Text = "󰉿",
            Method = "󰆧",
            Function = "󰊕",
            Constructor = "",
            Field = "󰜢",
            Variable = "󰀫",
            Class = "󰠱",
            Interface = "",
            Module = "",
            Property = "󰜢",
            Unit = "󰑭",
            Value = "󰎠",
            Enum = "",
            Keyword = "󰌋",
            Snippet = "",
            Color = "󰏘",
            File = "󰈙",
            Reference = "󰈇",
            Folder = "󰉋",
            EnumMember = "",
            Constant = "󰏿",
            Struct = "󰙅",
            Event = "",
            Operator = "󰆕",
            TypeParameter = "",
            Copilot = "",
            Const = "󰏿",
          }
          vim_item.kind = string.format("%s %s", icons[vim_item.kind] or "", vim_item.kind)
          vim_item.menu = ({
            copilot = "[Copilot]",
            nvim_lsp = "[LSP]",
            luasnip = "[Snippet]",
            buffer = "[Buffer]",
            path = "[Path]",
          })[entry.source.name]
          return vim_item
        end,
      },
      sorting = {
        priority_weight = 2,
        comparators = comparators,
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      -- Disable CMP ghost_text to avoid clashing with Copilot inline suggestions
      experimental = { ghost_text = false },
    })

    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = { { name = "buffer" } },
    })

    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
      matching = { disallow_symbol_nonprefix_matching = false },
    })
  end,
}
