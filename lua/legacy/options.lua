-- disable
-- vim.g.loaded_gzip = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- vim.g.loaded_tarPlugin = 1
-- vim.g.loaded_tohtml = 1
-- vim.g.loaded_zipPlugin = 1

vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python_provider = 0
vim.g.loaded_ruby_provider = 0

vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

vim.opt.autoindent = true
vim.opt.background = 'dark'
vim.opt.backup = false
vim.opt.breakindent = true
vim.opt.clipboard = 'unnamedplus' -- Sync with system clipboard
-- vim.opt.cmdheight = 0
vim.opt.completeopt = { 'menu', 'menuone', 'noselect', 'noinsert', 'preview' }
vim.opt.confirm = true
vim.opt.copyindent = true
vim.opt.cursorline = true
vim.opt.cursorlineopt = 'number'
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.fileformat = 'unix'
vim.opt.fileformats = { 'unix', 'dos' }
vim.opt.fillchars = {
  foldopen = '',
  foldclose = '',
  fold = '·',
  foldsep = ' ',
  -- diff = '╱',
  eob = ' ', -- disable `~` on nonexistent lines
}
-- vim.opt.foldcolumn = '1'
vim.opt.foldenable = true
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldlevel = 99
vim.opt.foldmethod = 'expr'
-- vim.opt.foldtext = ''
-- vim.opt.grepformat = '%f:%l:%c:%m'
-- vim.opt.grepprg = 'rg --vimgrep'
-- vim.opt.laststatus = 3
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
vim.opt.mouse = 'a'
vim.opt.number = true
vim.opt.path:append('**')
vim.opt.pumheight = 16
vim.opt.relativenumber = true
vim.opt.scrolloff = 4
vim.opt.shiftwidth = 2
-- vim.opt.showcmdloc = 'statusline'
vim.opt.showmode = false
vim.opt.showtabline = 2
vim.opt.sidescrolloff = 8
vim.opt.signcolumn = 'yes:2'
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.softtabstop = 2
vim.opt.splitkeep = 'screen'
vim.opt.splitright = true
vim.opt.splitbelow = true
-- vim.opt.statuscolumn = '%s%l%C'
vim.opt.swapfile = false
vim.opt.synmaxcol = 1000
vim.opt.tabstop = 2
vim.opt.termguicolors = true
vim.opt.timeoutlen = 500
vim.opt.title = true
vim.opt.undodir = vim.fn.stdpath('data') .. '/undodir'
vim.opt.undofile = true
vim.opt.updatetime = 300
vim.opt.virtualedit = 'block'
vim.opt.wildmenu = true
vim.opt.wildmode = 'longest:full,full'
vim.opt.winborder = 'single'
vim.opt.wrap = false
vim.opt.writebackup = false

if vim.fn.has('win32') == 1 then
  vim.o.shell = 'pwsh'
  vim.o.shellcmdflag =
  "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command $PSStyle.OutputRendering = 'PlainText';"
  vim.o.shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
  vim.o.shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
  vim.o.shellquote = ''
  vim.o.shellxquote = ''
end

-- vim.cmd('syntax off')
