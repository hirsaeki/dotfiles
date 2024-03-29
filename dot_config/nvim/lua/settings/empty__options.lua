-- https://vim-jp.org/vimdoc-ja/options.html
local options = {
  encoding = "utf-8",
  ambiwidth = "double",
  pumblend = 10,
  fileencodings = "utf-8,cp932,sjis,euc-jp,iso-2022-jp",
  fileformats = "unix,mac,dos",
  cursorline = true,
  ignorecase = true,
  smartcase = true,
  scrollback = 100000,
  tabstop = 2,
  softtabstop = 2,
  shiftwidth = 2,
  modelines = 5,
  expandtab = true,
  smartindent = true,
  autoindent = true,
  backspace = 2,
  nowrapscan = true,
  showmatch = true,
  wildmenu = true,
  wildmode = "list:longest",
  hidden = true,
  autoread = true,
  number = true,
  ruler = true,
  nolist = true,
  wrap = true,
  laststatus = 2,
  cmdheight = 1,
  showcmd = true,
  title = true,
  backupext = ".bak",
  undofile = true,
  scrolloff = 999,
  foldmethod = "marker",
  fillchars = 'vert:I " :vsplit (i)',
  history = 200,
  matchtime = 2,
  hlsearch = true,
  list = true,
  splitbelow = false,
  splitright = false,
  listchars = "tab:>.,trail:_,eol:↲,extends:>,precedes:<,nbsp:%",
}

vim.opt.shortmess:append("c")
vim.opt.formatoptions:append("mM")

for k, v in pairs(options) do
  vim.opt[k] = v
end
