-- disable
-- vim.g.loaded_gzip = 1
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1
-- vim.g.loaded_tarPlugin = 1
-- vim.g.loaded_tohtml = 1
-- vim.g.loaded_zipPlugin = 1

vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python_provider = 0
vim.g.loaded_ruby_provider = 0

vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

vim.g.netrw_altv = 1
vim.g.netrw_browse_split = 4
vim.g.netrw_liststyle = 3
vim.g.netrw_preview = 1
vim.g.netrw_winsize = 16

vim.opt.autoindent = true
vim.opt.background = 'dark'
vim.opt.backspace = { 'indent', 'eol', 'start', 'nostop' } -- don't stop backspace at insert
vim.opt.backup = false
vim.opt.breakindent = true
vim.opt.clipboard = 'unnamedplus' -- Sync with system clipboard
-- vim.opt.cmdheight = 0
vim.opt.colorcolumn = '160'
vim.opt.completeopt = { 'menu', 'menuone', 'noinsert', 'popup', 'fuzzy', 'nosort' } -- { 'menu', 'menuone', 'noselect', 'noinsert', 'popup', 'fuzzy', 'nosort' }
vim.opt.confirm = true
vim.opt.copyindent = true
vim.opt.cursorline = true
vim.opt.cursorlineopt = 'number'
vim.opt.diffopt = { 'internal', 'filler', 'closeoff', 'algorithm:histogram', 'linematch:60' }
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.fileformat = 'unix'
vim.opt.fileformats = { 'unix', 'dos' }
vim.opt.fillchars = {
  -- fold = '·',
  foldopen = '󰅀',
  foldclose = '󰅂',
  -- foldsep = ' ',
  diff = '╱',
  eob = ' ', -- disable `~` on nonexistent lines
}
vim.opt.foldcolumn = '1'
vim.opt.foldenable = true
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldlevel = 99
vim.opt.foldmethod = 'expr'
vim.opt.foldtext = ''
vim.opt.guicursor = 'n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20'
vim.opt.hlsearch = true
vim.opt.ignorecase = true
-- vim.opt.inccommand = 'split'
vim.opt.incsearch = true
vim.opt.infercase = true
vim.opt.jumpoptions = { 'stack', 'view', 'clean' }
vim.opt.laststatus = 3
vim.opt.mouse = 'a'
vim.opt.number = true
vim.opt.numberwidth = 1
vim.opt.path = '.,,**'
vim.opt.pumheight = 16
vim.opt.relativenumber = true
vim.opt.ruler = false
vim.opt.scrolloff = 4
vim.opt.shiftround = true
vim.opt.shiftwidth = 0 -- number of space inserted for indentation; when zero the 'tabstop' value will be used
vim.opt.showcmd = false
vim.opt.showmode = false
vim.opt.showtabline = 2
vim.opt.sidescrolloff = 8
vim.opt.signcolumn = 'yes:2'
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.smoothscroll = true
vim.opt.softtabstop = -1
vim.opt.splitbelow = true
vim.opt.splitkeep = 'screen'
vim.opt.splitright = true
vim.opt.statuscolumn = '%s%=%l%{%v:virtnum == 0 && foldlevel(v:lnum) > foldlevel(v:lnum-1) ? "%C" : " "%}' -- '%s%=%l%C'
vim.opt.swapfile = false
vim.opt.synmaxcol = 1000
-- vim.opt.syntax = 'OFF'
vim.opt.tabstop = 2
vim.opt.termguicolors = true
vim.opt.timeoutlen = 500
vim.opt.title = true
vim.opt.ttimeoutlen = 25
vim.opt.undofile = true
vim.opt.undolevels = 10000
vim.opt.updatetime = 300
vim.opt.virtualedit = 'block'
vim.opt.wildmenu = true
vim.opt.wildmode = 'longest:full,full'
vim.opt.wildoptions = { --[['fuzzy',]] 'pum', 'tagfile' }
vim.opt.winborder = 'none'
vim.opt.wrap = false
vim.opt.writebackup = false

if vim.fn.executable('nu') == 1 then
  vim.opt.shell = 'nu'
  vim.opt.shellcmdflag = '--stdin --no-newline -c'
  vim.opt.shellpipe = '| complete | update stderr { ansi strip } | tee { get stderr | save --force --raw %s } | into record'
  vim.opt.shellquote = ''
  vim.opt.shellredir = 'out+err> %s'
  vim.opt.shellslash = true
  vim.opt.shelltemp = false
  vim.opt.shellxescape = ''
  vim.opt.shellxquote = ''
end

MiniDeps.later(function()
  vim.diagnostic.config({
    -- virtual_text = true,
    virtual_text = {
      severity = { min = 'INFO' }
    },
    -- underline = true,
    underline = {
      severity = {
        min = 'HINT',
        max = 'ERROR',
      }
    },
    update_in_insert = true,
    severity_sort = true,
    float = {
      focusable = true,
      style = 'minimal',
      border = 'none',
      source = true,
      header = '',
      prefix = '',
    },
    signs = {
      priority = 0,
      severity = { min = 'INFO' },
      text = {
        [vim.diagnostic.severity.ERROR] = '󰅚',
        [vim.diagnostic.severity.WARN] = '󰀪',
        [vim.diagnostic.severity.INFO] = '󰋽',
        [vim.diagnostic.severity.HINT] = '󰌶',
      },
    },
  })
end)
