vim.pack.add({
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects' },
  { src = 'https://github.com/neovim/nvim-lspconfig' },
  { src = 'https://github.com/nvim-mini/mini.nvim' },
  { src = 'https://github.com/folke/snacks.nvim' },
  { src = 'https://github.com/Saghen/blink.cmp',                           version = 'v1.6.0' },
  { src = 'https://github.com/lewis6991/gitsigns.nvim' }
})
-- vim.pack.update(vim.pack.get())

-- package.preload['nvim-web-devicons'] = function()
--   require('mini.icons').mock_nvim_web_devicons()
--   return package.loaded['nvim-web-devicons']
-- end

require('snacks').setup({
  -- your configuration comes here
  -- or leave it empty to use the default settings
  -- refer to the configuration section below
  -- bigfile = { enabled = true },
  -- dashboard = { enabled = true },
  -- explorer = { enabled = true },
  -- image = { enabled = true },
  indent = {
    enabled = true,
    indent = { char = '▏' },
    scope = { char = '▏' },
    animate = { enabled = false },
  },
  input = {
    enabled = false,
    border = 'single',
  },
  picker = {
    enabled = true,
    -- layout = {
    --   border = 'none',
    -- },
    layout = 'layout',
    layouts = {
      layout = {
        layout = {
          box = 'horizontal',
          width = 0.8,
          min_width = 120,
          height = 0.8,
          {
            box = 'vertical',
            border = 'rounded',
            title = '{title} {live} {flags}',
            { win = 'input', height = 1,     border = 'bottom' },
            { win = 'list',  border = 'none' },
          },
          { win = 'preview', title = '{preview}', border = 'rounded', width = 0.5 },
        }
      },
    },
  },
  -- notifier = { enabled = true },
  -- quickfile = { enabled = true },
  scope = { enabled = true },
  -- scroll = { enabled = true },
  -- statuscolumn = { enabled = true },
  -- words = { enabled = true },
})

vim.keymap.set('n', '<leader>fb', function() Snacks.picker.buffers() end, { desc = 'Find Buffers' })
vim.keymap.set('n', '<leader>ff', function() Snacks.picker.files() end, { desc = 'Find Files' })
vim.keymap.set('n', '<leader>fF', function() Snacks.picker.files({ hidden = true, ignored = true }) end, { desc = 'Find all files' })
vim.keymap.set('n', '<leader>fk', function() Snacks.picker.keymaps() end, { desc = 'Find keymaps' })
vim.keymap.set('n', '<leader>fs', function() Snacks.picker.smart() end, { desc = 'Find buffers/recent/files' })
vim.keymap.set('n', '<leader>ft', function() Snacks.picker.colorschemes() end, { desc = 'Colorschemes' })
vim.keymap.set('n', '<leader>fu', function() Snacks.picker.undo() end, { desc = 'Find undo history' })
vim.keymap.set('n', '<leader>fw', function() Snacks.picker.grep() end, { desc = 'Find Words' })
vim.keymap.set('n', '<leader>fW', function() Snacks.picker.grep({ hidden = true, ignored = true }) end, { desc = 'Find words in all files' })
vim.keymap.set('n', '<leader>ls', function() Snacks.picker.lsp_symbols() end, { desc = 'Search symbols' })
vim.keymap.set('n', 'gd', function() Snacks.picker.lsp_definitions() end, { desc = 'Goto Definition' })
vim.keymap.set('n', 'gD', function() Snacks.picker.lsp_declarations() end, { desc = 'Goto Declaration' })
vim.keymap.set('n', 'gy', function() Snacks.picker.lsp_type_definitions() end, { desc = 'Goto T[y]pe Definition' })
vim.keymap.set('n', '<leader>c', function() Snacks.bufdelete({ wipe = true }) end, { desc = 'Close buffer' })

require('nvim-treesitter.configs').setup({
  ensure_installed = {
    'astro',
    'c',
    'cpp',
    'css',
    'csv',
    'diff',
    'dockerfile',
    'editorconfig',
    'git_config',
    'git_rebase',
    'gitattributes',
    'gitcommit',
    'gitignore',
    'go',
    'html',
    'hlsl',
    'javascript',
    'jsdoc',
    'json',
    'jsonc',
    'lua',
    'markdown',
    'markdown_inline',
    'nu',
    'python',
    'query',
    'regex',
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


-- require('mini.ai').setup({
--   mappings = {
--     around_next = '',
--     inside_next = '',
--     around_last = '',
--     inside_last = '',
--     goto_left   = '',
--     goto_right  = '',
--   },
--   silent = true
-- })

require('mini.comment').setup({
  mappings = {
    comment = 'gc',
    comment_line = 'gcc',
    comment_visual = 'gc',
    textobject = 'igc',
  },
})

require('mini.git').setup()

require('mini.icons').setup({
  lsp = {
    array = { glyph = '' },
    boolean = { glyph = '' },
    key = { glyph = '' },
    namespace = { glyph = '' },
    null = { glyph = '' },
    number = { glyph = '' },
    object = { glyph = '' },
    package = { glyph = '' },
    string = { glyph = '' },
    class = { glyph = '' },
    color = { glyph = '' },
    constant = { glyph = '' },
    constructor = { glyph = '' },
    enum = { glyph = '' },
    enummember = { glyph = '' },
    event = { glyph = '' },
    field = { glyph = '' },
    file = { glyph = '' },
    folder = { glyph = '' },
    ['function'] = { glyph = '' },
    interface = { glyph = '' },
    keyword = { glyph = '' },
    method = { glyph = '' },
    module = { glyph = '' },
    operator = { glyph = '' },
    property = { glyph = '' },
    reference = { glyph = '' },
    snippet = { glyph = '' },
    struct = { glyph = '' },
    text = { glyph = '' },
    typeparameter = { glyph = '' },
    unit = { glyph = '' },
    value = { glyph = '' },
    variable = { glyph = '' },
  }
})

require('mini.notify').setup()
require('mini.pairs').setup()

require('mini.statusline').setup({
  use_icons = true,
  content = {
    active = function()
      local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
      mode = string.upper(mode)

      local recording_register = vim.fn.reg_recording()
      local macro_recording = ''
      if recording_register ~= '' then
        macro_recording = '  @' .. recording_register
      end

      local git         = MiniStatusline.section_git({ trunc_width = 40 })
      local diff        = MiniStatusline.section_diff({ trunc_width = 75 })
      local filename    = '%f%m%r' -- MiniStatusline.section_filename({ trunc_width = 140 })
      local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75, icon = '', signs = { ERROR = '󰅚 ', WARN = '󰀪 ', INFO = '󰋽 ', HINT = '󰌶 ' } }) -- vim.diagnostic.status()
      local search      = MiniStatusline.section_searchcount({ trunc_width = 75 })
      local lsp         = MiniStatusline.section_lsp({ trunc_width = 75 })
      local fileinfo    = MiniStatusline.section_fileinfo({ trunc_width = 120 })
      local location    = '%-7.(%l,%c%V%) %P' -- MiniStatusline.section_location({ trunc_width = 75 })
      local treesitter  = vim.treesitter.highlighter.active[vim.api.nvim_get_current_buf()] and '' or ''

      return MiniStatusline.combine_groups({
        { hl = mode_hl,                 strings = { mode, macro_recording } },
        { hl = 'MiniStatuslineDevinfo', strings = { git, diff } },
        '%<',
        { hl = 'MiniStatuslineFilename', strings = { filename } },
        { hl = 'MiniStatuslineDevinfo',  strings = { diagnostics } },
        '%=',
        { hl = 'MiniStatuslineDevinfo',  strings = { search } },
        '%=',
        { hl = 'MiniStatuslineDevinfo',  strings = { lsp } },
        { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
        { hl = 'MiniStatuslineDevinfo',  strings = { treesitter } },
        { hl = mode_hl,                  strings = { location } },
      })
    end,
  },
})

require('mini.tabline').setup({
  format = function(buf_id, label)
    local suffix = vim.bo[buf_id].modified and ' ' or ''
    local default_formatted = MiniTabline.default_format(buf_id, label)
    return default_formatted .. suffix
  end,
})


require('blink.cmp').setup({
  -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
  -- 'super-tab' for mappings similar to vscode (tab to accept)
  -- 'enter' for enter to accept
  -- 'none' for no mappings
  --
  -- All presets have the following mappings:
  -- C-space: Open menu or open docs if already open
  -- C-n/C-p or Up/Down: Select next/previous item
  -- C-e: Hide menu
  -- C-k: Toggle signature help (if signature.enabled = true)
  --
  -- See :h blink-cmp-config-keymap for defining your own keymap
  keymap = {
    preset = 'none',
    ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
    ['<C-e>'] = { 'hide', 'fallback' },
    ['<CR>'] = {
      function(cmp)
        if cmp.snippet_active() then
          return cmp.accept()
        else
          return cmp.select_and_accept()
        end
      end, 'fallback'
    },
    ['<Tab>'] = {
      function(cmp)
        if cmp.snippet_active() then
          return cmp.accept()
        else
          return cmp.select_and_accept()
        end
      end,
      'snippet_forward',
      'fallback'
    },
    ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
    ['<Up>'] = { 'select_prev', 'fallback' },
    ['<Down>'] = { 'select_next', 'fallback' },
    ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
    ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },
    ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
    ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
    ['<C-s>'] = { 'show_signature', 'hide_signature', 'fallback' },
  },

  completion = {
    list = { selection = { preselect = true, auto_insert = false } },
    menu = {
      auto_show = function(ctx) return ctx.mode ~= 'cmdline' end,
      winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None',
      draw = {
        treesitter = { 'lsp' },
        components = {
          kind_icon = {
            text = function(ctx)
              local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
              return kind_icon
            end,
            highlight = function(ctx)
              local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
              return hl
            end,
          },
          kind = {
            highlight = function(ctx)
              local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
              return hl
            end,
          }
        },
      },
    },
    accept = {
      auto_brackets = { enabled = true },
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 0,
      window = {
        winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None',
      },
    },
  },

  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },

  fuzzy = { implementation = 'prefer_rust_with_warning' },

  signature = {
    enabled = true,
    window = {
      border = 'none',
      winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder',
    }
  }
})
