local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

add('neovim/nvim-lspconfig')
add({
  source = 'nvim-treesitter/nvim-treesitter',
  checkout = 'master',
  monitor = 'main',
  hooks = { post_checkout = function() vim.cmd('TSUpdate') end },
})
add({
  source = 'nvim-treesitter/nvim-treesitter-textobjects',
  checkout = 'master',
  monitor = 'main',
})
add('nvim-mini/mini.nvim')
add({
  source = 'saghen/blink.cmp',
  depends = { 'T1ckbase/vscode-snippets' },
  checkout = 'v1.6.0',
})
add('Mofiqul/vscode.nvim')

local utils = require('utils')
utils.setup()

now(function()
  require('mini.notify').setup()
end)

now(function()
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
          ['af'] = { query = '@call.outer', desc = 'around function call' },
          ['if'] = { query = '@call.inner', desc = 'inside function call' },
          ['ac'] = { query = '@class.outer', desc = 'around class' },
          ['ic'] = { query = '@class.inner', desc = 'inside class' },
          ['a?'] = { query = '@conditional.outer', desc = 'around conditional' },
          ['i?'] = { query = '@conditional.inner', desc = 'inside conditional' },
          ['am'] = { query = '@function.outer', desc = 'around method/function definition' },
          ['im'] = { query = '@function.inner', desc = 'inside method/function definition' },
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
          [']f'] = { query = '@call.outer', desc = 'Next function call start' },
          [']c'] = { query = '@class.outer', desc = 'Next class start' },
          [']?'] = { query = '@conditional.outer', desc = 'Next conditional start' },
          [']m'] = { query = '@function.outer', desc = 'Next method/function definition start' },
          [']a'] = { query = '@parameter.inner', desc = 'Next argument start' },
        },
        goto_next_end = {
          [']K'] = { query = '@block.outer', desc = 'Next block end' },
          [']F'] = { query = '@call.outer', desc = 'Next function call end' },
          [']C'] = { query = '@class.outer', desc = 'Next class end' },
          [']M'] = { query = '@function.outer', desc = 'Next method/function definition end' },
          [']A'] = { query = '@parameter.inner', desc = 'Next argument end' },
        },
        goto_previous_start = {
          ['[k'] = { query = '@block.outer', desc = 'Previous block start' },
          ['[f'] = { query = '@call.outer', desc = 'Previous function call start' },
          ['[c'] = { query = '@class.outer', desc = 'Previous class start' },
          ['[?'] = { query = '@conditional.outer', desc = 'Previous conditional start' },
          ['[m'] = { query = '@function.outer', desc = 'Previous method/function definition start' },
          ['[a'] = { query = '@parameter.inner', desc = 'Previous argument start' },
        },
        goto_previous_end = {
          ['[K'] = { query = '@block.outer', desc = 'Previous block end' },
          ['[F'] = { query = '@call.outer', desc = 'Previous function call end' },
          ['[C'] = { query = '@class.outer', desc = 'Previous class end' },
          ['[M'] = { query = '@function.outer', desc = 'Previous method/function definition end' },
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
end)


now(function()
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
  -- later(MiniIcons.tweak_lsp_kind)
end)

now(function()
  require('mini.ai').setup({
    custom_textobjects = {
      b = false,
      f = false,
      a = false,
      ['?'] = false
    },
    mappings = {
      around_next = '',
      inside_next = '',
      around_last = '',
      inside_last = '',
      -- goto_left   = '',
      -- goto_right  = '',
    },
    n_lines = 69,
    silent = true
  })
end)

now(function()
  require('mini.bufremove').setup()
end)

now(function()
  local miniclue = require('mini.clue')
  miniclue.setup({
    triggers = {
      -- Leader triggers
      { mode = 'n', keys = '<Leader>' },
      { mode = 'x', keys = '<Leader>' },
      -- Bracket
      { mode = 'n', keys = '[' },
      { mode = 'n', keys = ']' },
      { mode = 'x', keys = '[' },
      { mode = 'x', keys = ']' },
      -- Built-in completion
      { mode = 'i', keys = '<C-x>' },
      -- `g` key
      { mode = 'n', keys = 'g' },
      { mode = 'x', keys = 'g' },
      -- Marks
      { mode = 'n', keys = "'" },
      { mode = 'n', keys = '`' },
      { mode = 'x', keys = "'" },
      { mode = 'x', keys = '`' },
      -- Registers
      { mode = 'n', keys = '"' },
      { mode = 'x', keys = '"' },
      { mode = 'i', keys = '<C-r>' },
      { mode = 'c', keys = '<C-r>' },
      -- Window commands
      { mode = 'n', keys = '<C-w>' },
      -- `z` key
      { mode = 'n', keys = 'z' },
      { mode = 'x', keys = 'z' },
      -- Text objects
      { mode = 'o', keys = 'a' },
      { mode = 'o', keys = 'i' },
      { mode = 'x', keys = 'a' },
      { mode = 'x', keys = 'i' },
    },
    clues = {
      -- Enhance this by adding descriptions for <Leader> mapping groups
      miniclue.gen_clues.builtin_completion(),
      miniclue.gen_clues.g(),
      miniclue.gen_clues.marks(),
      miniclue.gen_clues.registers({ show_contents = true }),
      miniclue.gen_clues.windows(),
      miniclue.gen_clues.z(),
    },
    window = {
      config = {
        width = 42
      }
    }
  })
end)

now(function()
  require('mini.comment').setup({
    mappings = {
      comment = 'gc',
      comment_line = 'gcc',
      comment_visual = 'gc',
      textobject = 'igc',
    },
  })
end)

now(function()
  -- require('mini.completion').setup({
  --   lsp_completion = {
  --     process_items = function(items, base)
  --       local processed_items = MiniCompletion.default_process_items(items, base)
  --       return processed_items
  --     end
  --   }
  -- })
end)

now(function()
  require('mini.cursorword').setup({
    delay = 0
  })
end)

now(function()
  require('mini.diff').setup({
    view = {
      style = 'sign',
      signs = { add = '▎', change = '▎', delete = 'ˍ' },
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
end)

now(function()
  require('mini.extra').setup()
end)

now(function()
  require('mini.files').setup({
    mappings = {
      go_in_plus = '<CR>'
    },
    options = {
      use_as_default_explorer = true,
    },
    windows = {
      preview = true
    }
  })
end)

now(function()
  require('mini.git').setup()
end)

now(function()
  require('mini.indentscope').setup({
    draw = {
      delay = 0,
      animation = require('mini.indentscope').gen_animation.none(),
      predicate = function(scope) return scope.border.indent > 1 end
    },
    symbol = '▏'
  })
end)

now(function()
  require('mini.jump2d').setup({
    view = {
      dim = true
    },
    allowed_windows = {
      not_current = false,
    },
    silent = true
  })
end)

now(function()
  require('mini.keymap').setup()
  local notify_many_keys = function(key)
    local lhs = string.rep(key, 5)
    local action = function() vim.notify('Too many ' .. key) end
    MiniKeymap.map_combo({ 'n', 'x' }, lhs, action)
  end
  notify_many_keys('h')
  notify_many_keys('j')
  notify_many_keys('k')
  notify_many_keys('l')
end)

now(function()
  require('mini.misc').setup_restore_cursor()
end)

now(function()
  require('mini.move').setup()
end)

now(function()
  require('mini.pairs').setup({
    mappings = {
      ['"'] = {
        action = 'closeopen',
        pair = '""',
        neigh_pattern = '[^%w\\][^%w\\]',
        register = { cr = false },
      },
      ["'"] = {
        action = 'closeopen',
        pair = "''",
        neigh_pattern = '[^%w\\][^%w\\]',
        register = { cr = false },
      },
      ['`'] = {
        action = 'closeopen',
        pair = '``',
        neigh_pattern = '[^%w\\][^%w\\]',
        register = { cr = false },
      },
    }
  })
end)

now(function()
  require('mini.pick').setup()
  vim.ui.select = MiniPick.ui_select
end)

now(function()
  require('mini.sessions').setup()
  vim.api.nvim_create_user_command('SaveSession', function() MiniSessions.write(vim.fn.getcwd():gsub('[\\/:]', '%%') .. '.vim', { force = true }) end, {})
end)

now(function()
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
end)

now(function()
  require('mini.surround').setup({
    silent = true
  })
end)

now(function()
  require('mini.tabline').setup({
    format = function(buf_id, label)
      local suffix = vim.bo[buf_id].modified and ' ' or ''
      local default_formatted = MiniTabline.default_format(buf_id, label)
      return default_formatted .. suffix
    end,
  })
end)

now(function()
  local starter = require('mini.starter')
  starter.setup({
    header = 'welcome',
    -- footer = function()
    --   local plugins = MiniDeps.get_session()
    --   return string.format('Neovim loaded %d/%d plugins', #plugins, #plugins)
    -- end
  })
end)



later(function()
  local gen_loader = require('mini.snippets').gen_loader
  require('mini.snippets').setup({
    snippets = {
      -- gen_loader.from_file(vim.fn.stdpath('config') .. '/snippets/global.json'),
      gen_loader.from_lang({
        lang_patterns = {
          javascriptreact = { 'javascript.json' },
          jsx = { 'javascript.json' },
          typescriptreact = { 'typescript.json' },
          tsx = { 'typescript.json' },
          markdown_inline = { 'markdown.json' },
        }
      }),
    },
    mappings = {
      expand = '',
      jump_next = '',
      jump_prev = '',
      stop = '<C-c>',
    },
    expand = {
      insert = function(snippet, _)
        vim.snippet.expand(snippet.body)
      end
    }
  })
  -- MiniSnippets.start_lsp_server()
end)

later(function()
  require('blink.cmp').setup({
    keymap = {
      preset = 'none',
      ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
      ['<C-e>'] = { 'hide', 'fallback' },
      ['<CR>'] = { 'accept', 'fallback' },
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
      trigger = {
        prefetch_on_insert = false,
      },
      menu = {
        auto_show = function(ctx) return ctx.mode ~= 'cmdline' end,
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
    snippets = { preset = 'mini_snippets' },
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
        border = 'single',
        show_documentation = true,
        winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder',
      }
    }
  })
end)
