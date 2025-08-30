local opt = vim.opt
opt.termguicolors = true
opt.wrap = true
opt.linebreak = true
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.termguicolors = true

opt.scrolloff = 8
opt.sidescrolloff = 8

opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true

opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = false

opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.updatetime = 300
opt.timeoutlen = 300

opt.undofile = true
opt.completeopt = { "menu", "menuone", "noselect" }

opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
opt.laststatus = 3

vim.diagnostic.config({
  virtual_text = {
    spacing = 3,
    wrap = true,
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

vim.lsp.set_log_level("error")
