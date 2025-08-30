vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ timeout = 200 })
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    -- Trim trailing whitespace without invoking command-line substitution
    local bufnr = 0
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local changed = false
    for i, line in ipairs(lines) do
      local new = line:gsub("%s+$", "")
      if new ~= line then
        lines[i] = new
        changed = true
      end
    end
    if changed then
      local view = vim.fn.winsaveview()
      vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
      vim.fn.winrestview(view)
    end
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    local dir = vim.fn.expand("<afile>:p:h")
    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, "p")
    end
  end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "gitcommit" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.spell = false
  end,
})

-- Diagnostics float that auto-closes and never gets stuck
local grp = vim.api.nvim_create_augroup("DiagFloat", { clear = true })

vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
  group = grp,
  desc = "Show diagnostics under cursor without sticky floats",
  callback = function()
    -- Only open if there are diagnostics at cursor line
    local pos = vim.api.nvim_win_get_cursor(0)
    local diags = vim.diagnostic.get(0, { lnum = pos[1] - 1 })
    if not diags or #diags == 0 then
      return
    end

    -- Prevent re-opening if a float is already visible for this buffer
    local win = vim.b.diag_float_win
    if win and vim.api.nvim_win_is_valid(win) then
      return
    end

    win = vim.diagnostic.open_float(nil, {
      focusable = false,
      scope = "cursor",
      source = "if_many",
      severity_sort = true,
      close_events = {
        "CursorMoved",
        "CursorMovedI",
        "BufHidden",
        "InsertEnter",
        "WinScrolled",
        "FocusLost",
      },
    })

    -- Track window and clear var when it closes
    if type(win) == "number" then
      vim.b.diag_float_win = win
      vim.api.nvim_create_autocmd("WinClosed", {
        group = grp,
        buffer = 0,
        once = true,
        callback = function(args)
          if tonumber(args.match) == win then
            vim.b.diag_float_win = nil
          end
        end,
      })
    end
  end,
})
