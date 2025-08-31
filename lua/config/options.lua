vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python_provider = 0
vim.g.loaded_ruby_provider = 0

vim.opt.autoindent = true
vim.opt.background = 'dark'
vim.opt.backup = false
vim.opt.breakindent = true
vim.opt.clipboard = 'unnamedplus' -- Sync with system clipboard
-- vim.opt.cmdheight = 0
vim.opt.completeopt = { 'menu', 'menuone', 'noselect', 'noinsert', 'preview' }
vim.opt.confirm = true
vim.opt.copyindent = true
-- vim.opt.cursorline = true
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.fileformat = 'unix'
vim.opt.fileformats = { 'unix', 'dos' }
vim.opt.fillchars = {
  foldopen = '',
  foldclose = '',
  -- fold = ' ',
  -- foldsep = ' ',
  -- diff = '╱',
  eob = ' ', -- disable `~` on nonexistent lines
}
vim.opt.foldlevel = 99
-- vim.opt.grepformat = '%f:%l:%c:%m'
-- vim.opt.grepprg = 'rg --vimgrep'
-- vim.opt.laststatus = 3
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.mouse = 'a'
vim.opt.number = true
vim.opt.path:append('**')
vim.opt.pumheight = 12
vim.opt.relativenumber = true
vim.opt.scrolloff = 4
vim.opt.shiftwidth = 2
vim.opt.showmode = false
vim.opt.showtabline = 2
vim.opt.sidescrolloff = 8
vim.opt.signcolumn = 'yes:2'
vim.opt.softtabstop = 2
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.splitkeep = 'screen'
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.swapfile = false
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

-- vim.opt.statusline =
-- [[%{v:lua.require('config.statusline').mode_component()} %< %f %h%w%m%r %=%{% &showcmdloc == 'statusline' ? '%-10.S ' : '' %}%{% exists('b:keymap_name') ? '<'..b:keymap_name..'> ' : '' %}%{% &busy > 0 ? '◐ ' : '' %}%(%{luaeval('(package.loaded[''vim.diagnostic''] and vim.diagnostic.status()) or '''' ')} %)%{% &ruler ? ( &rulerformat == '' ? '%-14.(%l,%c%V%) %P' : &rulerformat ) : '' %}]]

-- vim.cmd('syntax off')
-- print(vim.opt.fileformat)
