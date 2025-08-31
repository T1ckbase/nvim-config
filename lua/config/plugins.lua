vim.pack.add({
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects' },
  { src = 'https://github.com/neovim/nvim-lspconfig' },
  { src = 'https://github.com/nvim-mini/mini.nvim' },
  { src = 'https://github.com/lewis6991/gitsigns.nvim' }
})

require('nvim-treesitter.configs').setup({
  ensure_installed = {
    'c',
    'cpp',
    'css',
    'diff',
    'dockerfile',
    'go',
    'html',
    'javascript',
    'json',
    'lua',
    'markdown',
    'markdown_inline',
    'python',
    'query',
    'rust',
    'scss',
    'toml',
    'tsx',
    'typescript',
    'vim',
    'vimdoc',
    'yaml',
    'zig',
  },
  sync_install = false,
  auto_install = true,
  ignore_install = {},
  highlight = {
    enable = true,
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    -- disable = function(lang, buf)
    --   local max_filesize = 1000 * 1024 -- 1 MB
    --   local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
    --   if ok and stats and stats.size > max_filesize then
    --     return true
    --   end
    -- end,
    additional_vim_regex_highlighting = false,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj
      keymaps = {
        ['ak'] = { query = '@block.outer', desc = 'around block' },
        ['ik'] = { query = '@block.inner', desc = 'inside block' },
        ['ac'] = { query = '@class.outer', desc = 'around class' },
        ['ic'] = { query = '@class.inner', desc = 'inside class' },
        ['a?'] = { query = '@conditional.outer', desc = 'around conditional' },
        ['i?'] = { query = '@conditional.inner', desc = 'inside conditional' },
        ['af'] = { query = '@function.outer', desc = 'around function ' },
        ['if'] = { query = '@function.inner', desc = 'inside function ' },
        ['ao'] = { query = '@loop.outer', desc = 'around loop' },
        ['io'] = { query = '@loop.inner', desc = 'inside loop' },
        ['aa'] = { query = '@parameter.outer', desc = 'around argument' },
        ['ia'] = { query = '@parameter.inner', desc = 'inside argument' },
      }
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        [']k'] = { query = '@block.outer', desc = 'Next block start' },
        [']f'] = { query = '@function.outer', desc = 'Next function start' },
        [']a'] = { query = '@parameter.inner', desc = 'Next argument start' },
      },
      goto_next_end = {
        [']K'] = { query = '@block.outer', desc = 'Next block end' },
        [']F'] = { query = '@function.outer', desc = 'Next function end' },
        [']A'] = { query = '@parameter.inner', desc = 'Next argument end' },
      },
      goto_previous_start = {
        ['[k'] = { query = '@block.outer', desc = 'Previous block start' },
        ['[f'] = { query = '@function.outer', desc = 'Previous function start' },
        ['[a'] = { query = '@parameter.inner', desc = 'Previous argument start' },
      },
      goto_previous_end = {
        ['[K'] = { query = '@block.outer', desc = 'Previous block end' },
        ['[F'] = { query = '@function.outer', desc = 'Previous function end' },
        ['[A'] = { query = '@parameter.inner', desc = 'Previous argument end' },
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['>K'] = { query = '@block.outer', desc = 'Swap next block' },
        ['>F'] = { query = '@function.outer', desc = 'Swap next function' },
        ['>A'] = { query = '@parameter.inner', desc = 'Swap next argument' },
      },
      swap_previous = {
        ['<K'] = { query = '@block.outer', desc = 'Swap previous block' },
        ['<F'] = { query = '@function.outer', desc = 'Swap previous function' },
        ['<A'] = { query = '@parameter.inner', desc = 'Swap previous argument' },
      },
    },
  },
  modules = {},
})



require('mini.git').setup()
require('mini.icons').setup()
require('mini.pairs').setup()

require('mini.statusline').setup({
  use_icons = true,
  content = {
    -- This is the function that builds the statusline for the active window.
    active = function()
      -- These are the default sections provided by mini.statusline
      local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })

      local recording_register = vim.fn.reg_recording()
      local macro_section = ''
      if recording_register ~= '' then
        macro_section = '  @' .. recording_register
      end

      local treesitter  = vim.treesitter.highlighter.active[vim.api.nvim_get_current_buf()] and '' or ''

      local git         = MiniStatusline.section_git({ trunc_width = 40 })
      local diff        = MiniStatusline.section_diff({ trunc_width = 75 })
      local diagnostics = vim.diagnostic.status() -- MiniStatusline.section_diagnostics({ trunc_width = 75 })
      local lsp         = MiniStatusline.section_lsp({ trunc_width = 75 })
      local filename    = '%f%m%r'                -- MiniStatusline.section_filename({ trunc_width = 140 })
      local fileinfo    = MiniStatusline.section_fileinfo({ trunc_width = 120 })
      local location    = '%-6.(%l,%c%V%) %P'     -- MiniStatusline.section_location({ trunc_width = 75 })
      local search      = MiniStatusline.section_searchcount({ trunc_width = 75 })

      mode              = string.upper(mode)

      return MiniStatusline.combine_groups({
        { hl = mode_hl,                 strings = { mode } },
        { hl = 'MiniStatuslineDevinfo', strings = { git, diff } },
        '%<', -- Mark general truncate point
        { hl = 'MiniStatuslineFilename', strings = { filename } },
        { hl = 'MiniStatuslineDevinfo',  strings = { diagnostics } },
        '%=',
        { hl = 'MiniStatuslineDevinfo',  strings = { macro_section, search } },
        '%=',
        { hl = 'MiniStatuslineDevinfo',  strings = { lsp } },
        { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
        { hl = 'MiniStatuslineDevinfo',  strings = { treesitter } },
        { hl = mode_hl,                  strings = { location } },
      })
    end,
  },
})

require('mini.tabline').setup()
