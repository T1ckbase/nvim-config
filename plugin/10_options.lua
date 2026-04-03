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
vim.opt.backspace = { 'indent', 'eol', 'start', 'nostop' }
vim.opt.backup = false
vim.opt.breakindent = true
vim.opt.clipboard = 'unnamedplus' -- Sync with system clipboard
-- vim.opt.cmdheight = 0
vim.opt.colorcolumn = '+0'
vim.opt.completeopt = { 'menu', 'menuone', 'noinsert', 'popup', 'fuzzy' } -- { 'menu', 'menuone', 'noselect', 'noinsert', 'popup', 'fuzzy', 'nosort' }
vim.opt.confirm = true
vim.opt.copyindent = true
vim.opt.cursorline = true
vim.opt.cursorlineopt = 'number'
vim.opt.diffopt = { 'internal', 'filler', 'closeoff', 'indent-heuristic', 'inline:word', 'algorithm:histogram', 'linematch:60' }
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.fileformat = 'unix'
vim.opt.fileformats = { 'unix', 'dos' }
vim.opt.fillchars = {
  -- fold = '·',
  foldopen = '󰅀',
  foldclose = '󰅂',
  foldsep = ' ',
  foldinner = ' ',
  diff = ' ',
  eob = ' ', -- disable `~` on nonexistent lines
}
vim.opt.foldcolumn = '1'
vim.opt.foldenable = true
vim.opt.foldlevel = 99
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
-- vim.opt.mousemoveevent = true
vim.opt.number = true
vim.opt.numberwidth = 1
vim.opt.path = { '.', '', '**' }
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
vim.opt.statuscolumn = '%s%=%l%C' -- use foldcolumn='1' and fillchars: foldinner=' ' to hide fold level numbers
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
vim.opt.wildmode = { 'longest:full', 'full' } -- { 'noselect', 'full' }
vim.opt.wildoptions = { 'pum', 'tagfile' } -- { 'fuzzy', 'pum', 'tagfile' }
vim.opt.winborder = 'none'
vim.opt.wrap = false
vim.opt.writebackup = false

require('mini.misc').safely('later', function()
  vim.diagnostic.config({
    -- virtual_text = true,
    virtual_text = {
      severity = { min = vim.diagnostic.severity.INFO },
    },
    -- underline = true,
    underline = {
      severity = {
        min = vim.diagnostic.severity.HINT,
        max = vim.diagnostic.severity.ERROR,
      },
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
      severity = { min = vim.diagnostic.severity.INFO },
      text = {
        [vim.diagnostic.severity.ERROR] = '󰅚',
        [vim.diagnostic.severity.WARN] = '󰀪',
        [vim.diagnostic.severity.INFO] = '󰋽',
        [vim.diagnostic.severity.HINT] = '󰌶',
      },
    },
  })
end)
