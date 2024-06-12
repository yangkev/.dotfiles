local opt = vim.opt

opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.smarttab = true
opt.autoindent = true
opt.shiftround = true
opt.smartindent = false
opt.showmatch = true
opt.incsearch = true
opt.relativenumber = true
opt.wrap = false
opt.scrolloff = 8
opt.ttimeoutlen = 10
opt.lazyredraw = true
opt.wildignore = "*.o,*~,*.pyc,*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store,*.aux,*.fdb_latexmk,*.fls,*.gz"
opt.fillchars = opt.fillchars + "diff:/"
opt.swapfile = false
opt.termguicolors = true

-- show statusline in each window
opt.laststatus = 2

-- Reset clipboard behavior to normal since NvChad uses unnamedplus
opt.clipboard = ""

-- Recommended for auto-session: https://github.com/rmagatti/auto-session#recommended-sessionoptions-config
-- opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- Allow up to 2 signs per line (gitsign, diagnostic)
opt.signcolumn = "auto:2"

-- Undercurls are cool
vim.cmd([[
  hi DiagnosticUnderlineError gui=undercurl guisp=red
  hi DiagnosticUnderlineWarn gui=undercurl guisp=orange
]])

-- vim.cmd[[colorscheme tokyonight]]
