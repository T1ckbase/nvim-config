MiniDeps.add('neovim/nvim-lspconfig')
MiniDeps.add({
  source = 'nvim-treesitter/nvim-treesitter',
  checkout = 'master',
  monitor = 'main',
  hooks = { post_checkout = function() vim.cmd('TSUpdate') end },
})
MiniDeps.add({
  source = 'nvim-treesitter/nvim-treesitter-textobjects',
  checkout = 'master',
  monitor = 'main',
})
MiniDeps.add('nvim-mini/mini.nvim')
MiniDeps.add({
  source = 'saghen/blink.cmp',
  checkout = 'v1.6.0',
})

local utils = require('utils')
utils.setup()
utils.patch_convert_input_to_markdown_lines()

require('mini.notify').setup()
vim.notify = MiniNotify.make_notify()

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
    disable = function(lang, buf)
      local max_filesize = 1000 * 10 * 1024 -- 10 MB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,
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
-- MiniDeps.later(MiniIcons.tweak_lsp_kind)

-- require('mini.ai').setup({
--   mappings = {
--     around_next = '',
--     inside_next = '',
--     around_last = '',
--     inside_last = '',
--     goto_left   = '',
--     goto_right  = '',
--   }
-- })

if not vim.g.neovide then
  local animate = require('mini.animate')
  animate.setup({
    cursor = {
      enable = false,
      timing = animate.gen_timing.quadratic({ duration = 20, unit = 'total', easing = 'out' }),
    },
    scroll = {
      enable = true,
      timing = animate.gen_timing.quadratic({ duration = 50, unit = 'total', easing = 'out' }),
    },
    resize = {
      enable = false,
    },
    open = {
      enable = false,
    },
    close = {
      enable = false,
    }
  })
end

require('mini.bufremove').setup()

require('mini.comment').setup({
  mappings = {
    comment = 'gc',
    comment_line = 'gcc',
    comment_visual = 'gc',
    textobject = 'igc',
  },
})

-- require('mini.completion').setup({
--   lsp_completion = {
--     process_items = function(items, base)
--       local processed_items = MiniCompletion.default_process_items(items, base)
--       return processed_items
--     end
--   }
-- })

require('mini.cursorword').setup({
  delay = 0
})

require('mini.diff').setup({
  view = {
    style = 'sign',
    signs = { add = '▎', change = '▎', delete = '▎' },
  },
  source = {
    require('mini.diff').gen_source.git(),
    require('mini.diff').gen_source.none(),
  },
  mappings = {
    apply = '',
    -- reset = 'gH',
    -- textobject = 'gh',
    goto_first = '[H',
    goto_prev = '[h',
    goto_next = ']h',
    goto_last = ']H',
  },
})
vim.api.nvim_create_user_command('DiffClipboard', utils.diff_with_clipboard, {})
vim.api.nvim_create_user_command('DiffRestore', utils.restore_diff_source, {})

require('mini.extra').setup()
require('mini.git').setup()

require('mini.indentscope').setup({
  draw = {
    delay = 0,
    animation = require('mini.indentscope').gen_animation.none()
  },
  symbol = '▏'
})

require('mini.keymap').setup()

require('mini.misc').setup_restore_cursor()

require('mini.pairs').setup()
require('mini.pick').setup()
vim.ui.select = MiniPick.ui_select

require('mini.sessions').setup()

-- local gen_loader = require('mini.snippets').gen_loader
-- require('mini.snippets').setup({
--   snippets = {
--     gen_loader.from_file(vim.fn.stdpath('config') .. '/snippets/global.json'),
--     gen_loader.from_lang(),
--   },
--   mappings = {
--     expand = '',
--     jump_next = '',
--     jump_prev = '',
--     stop = '<c-c>',
--   },
-- })
-- MiniSnippets.start_lsp_server()

local starter = require('mini.starter')
starter.setup({
  header = 'welcome',
  footer = function()
    local plugins = MiniDeps.get_session()
    return string.format('Neovim loaded %d/%d plugins', #plugins, #plugins)
  end,
  content_hooks = {
    starter.gen_hook.adding_bullet(),
    starter.gen_hook.aligning('center', 'center'),
  },
})

require('mini.statusline').setup({
  use_icons = true,
  content = {
    active = function()
      local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
      mode = string.upper(mode)

      local macro_recording = utils.status.macro_recording({})
      local git = MiniStatusline.section_git({ trunc_width = 40 })
      local diff = MiniStatusline.section_diff({ trunc_width = 75 })
      local filename = [[%{substitute(fnamemodify(expand('%'),':~:.'),'\\','/','g')}%m%r]] -- MiniStatusline.section_filename({ trunc_width = 140 })
      local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75, icon = '', signs = { ERROR = '󰅚 ', WARN = '󰀪 ', INFO = '󰋽 ', HINT = '󰌶 ' } })
      local search = MiniStatusline.section_searchcount({ trunc_width = 75 })
      local lsp = utils.status.lsp({ trunc_width = 100 }) -- MiniStatusline.section_lsp({ trunc_width = 75 })
      local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
      local location = MiniStatusline.section_location({ trunc_width = 75 })
      local treesitter = vim.treesitter.highlighter.active[vim.api.nvim_get_current_buf()] and '' or ''
      local percentage = '%P'

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
        { hl = mode_hl,                  strings = { location, percentage } },
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
  appearance = {
    nerd_font_variant = 'normal'
  },
  completion = {
    list = { selection = { preselect = true, auto_insert = false } },
    menu = {
      -- auto_show = function(ctx) return ctx.mode ~= 'cmdline' end,
      auto_show = true,
      max_height = 12,
      scrollbar = true,
      winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None',
      draw = {
        components = {
          kind_icon = {
            text = function(ctx)
              local kind_icon, _, _ = MiniIcons.get('lsp', ctx.kind)
              return kind_icon
            end,
            highlight = function(ctx)
              local _, hl, _ = MiniIcons.get('lsp', ctx.kind)
              return hl
            end,
          },
          kind = {
            highlight = function(ctx)
              local _, hl, _ = MiniIcons.get('lsp', ctx.kind)
              return hl
            end,
          }
        },
      },
    },
    accept = {
      auto_brackets = { enabled = false },
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 0,
      window = {
        winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None',
      },
    },
  },
  -- snippets = { preset = 'mini_snippets' },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },
  fuzzy = {
    implementation = 'rust',
    sorts = {
      function(a, b)
        if (a.client_name == nil or b.client_name == nil) or (a.client_name == b.client_name) then
          return
        end
        return b.client_name == 'emmet_language_server'
      end,
      -- default sorts
      'score',
      'sort_text',
    }
  },
  signature = {
    enabled = true,
    window = {
      border = 'padded',
      show_documentation = true,
      winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder',
    }
  }
})
