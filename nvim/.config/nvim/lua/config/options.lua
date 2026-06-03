local opt = vim.opt

-- Indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.smarttab = true
opt.autoindent = true
opt.shiftround = true
opt.smartindent = false

-- Search
opt.showmatch = true
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

-- UI
opt.number = true
opt.relativenumber = true
opt.wrap = false
opt.scrolloff = 8
opt.cursorline = true
opt.termguicolors = true
opt.mouse = "a"

-- Splits open in a more natural direction
opt.splitright = true
opt.splitbelow = true

-- Persistent undo
opt.undofile = true

-- Faster key sequence completion; which-key popup delay
opt.ttimeoutlen = 10
opt.timeoutlen = 400

opt.wildignore = "*.o,*~,*.pyc,*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store,*.aux,*.fdb_latexmk,*.fls,*.gz"
opt.fillchars = opt.fillchars + "diff:/"
opt.swapfile = false

-- show statusline in each window
opt.laststatus = 2

-- Allow up to 2 signs per line (gitsign, diagnostic)
opt.signcolumn = "auto:2"

-- Undercurls are cool
vim.cmd([[
  hi DiagnosticUnderlineError gui=undercurl guisp=red
  hi DiagnosticUnderlineWarn gui=undercurl guisp=orange
]])
