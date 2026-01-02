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
-- add('saghen/blink.indent')
add({
  source = 'saghen/blink.cmp',
  depends = { 'T1ckbase/vscode-snippets' },
  checkout = 'v1.8.0', -- https://github.com/nvim-mini/mini.nvim/discussions/1896
})
add('sainnhe/gruvbox-material')

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
  -- later(MiniIcons.mock_nvim_web_devicons)
  -- later(MiniIcons.tweak_lsp_kind)
end)

now(function()
  require('mini.misc').setup()
  MiniMisc.setup_restore_cursor()
end)

now(function() require('mini.notify').setup() end)

now(function() require('mini.sessions').setup() end)

now(function()
  require('mini.statusline').setup({
    use_icons = true,
    content = {
      active = function()
        local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
        mode = string.upper(mode)

        -- local macro_recording = utils.status.macro_recording({})
        local git = MiniStatusline.section_git({ trunc_width = 40 })
        local diff = MiniStatusline.section_diff({ trunc_width = 75 })
        local filename = [[%{substitute(fnamemodify(expand('%'),':~:.'),'\\','/','g')}%m%r]] -- MiniStatusline.section_filename({ trunc_width = 140 })
        local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75, icon = '', signs = { ERROR = '󰅚 ', WARN = '󰀪 ', INFO = '󰋽 ', HINT = '󰌶 ' } })
        local search = MiniStatusline.section_searchcount({ trunc_width = 75 })
        local lsp = MiniStatusline.section_lsp({ trunc_width = 75 }) -- utils.status.lsp({ trunc_width = 100 }) -- MiniStatusline.section_lsp({ trunc_width = 75 })
        local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
        local location = MiniStatusline.section_location({ trunc_width = 75 })
        -- local treesitter = vim.treesitter.highlighter.active[vim.api.nvim_get_current_buf()] and '' or ''
        local percentage = '%P'

        return MiniStatusline.combine_groups({
          { hl = mode_hl,                 strings = { mode } },
          { hl = 'MiniStatuslineDevinfo', strings = { git, diff } },
          '%<',
          { hl = 'MiniStatuslineFilename', strings = { filename } },
          { hl = 'MiniStatuslineDevinfo',  strings = { diagnostics } },
          '%=',
          { hl = 'MiniStatuslineDevinfo',  strings = { search } },
          '%=',
          { hl = 'MiniStatuslineDevinfo',  strings = { lsp } },
          { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
          -- { hl = 'MiniStatuslineDevinfo',  strings = { treesitter } },
          { hl = mode_hl,                  strings = { location, percentage } },
        })
      end,
    },
  })
end)

now(function()
  require('mini.tabline').setup({
    format = function(buf_id, label)
      local suffix = vim.bo[buf_id].modified and ' ' or '  '
      local default_formatted = MiniTabline.default_format(buf_id, label)
      return ' ' .. default_formatted .. suffix
    end,
  })
end)

---

later(function()
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
      'hlsl',
      'html',
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
      'svelte',
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
        local max_filesize = 2 * 1024 * 1024 -- 2 MB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
          return true
        end
      end,
      additional_vim_regex_highlighting = false,
    },
    indent = {
      enable = true
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
          [']o'] = { query = '@loop.outer', desc = 'Next loop start' },
          [']a'] = { query = '@parameter.inner', desc = 'Next argument start' },
        },
        goto_next_end = {
          [']K'] = { query = '@block.outer', desc = 'Next block end' },
          [']F'] = { query = '@call.outer', desc = 'Next function call end' },
          [']C'] = { query = '@class.outer', desc = 'Next class end' },
          [']M'] = { query = '@function.outer', desc = 'Next method/function definition end' },
          [']O'] = { query = '@loop.outer', desc = 'Next loop end' },
          [']A'] = { query = '@parameter.inner', desc = 'Next argument end' },
        },
        goto_previous_start = {
          ['[k'] = { query = '@block.outer', desc = 'Previous block start' },
          ['[f'] = { query = '@call.outer', desc = 'Previous function call start' },
          ['[c'] = { query = '@class.outer', desc = 'Previous class start' },
          ['[?'] = { query = '@conditional.outer', desc = 'Previous conditional start' },
          ['[m'] = { query = '@function.outer', desc = 'Previous method/function definition start' },
          ['[o'] = { query = '@loop.outer', desc = 'Previous loop start' },
          ['[a'] = { query = '@parameter.inner', desc = 'Previous argument start' },
        },
        goto_previous_end = {
          ['[K'] = { query = '@block.outer', desc = 'Previous block end' },
          ['[F'] = { query = '@call.outer', desc = 'Previous function call end' },
          ['[C'] = { query = '@class.outer', desc = 'Previous class end' },
          ['[M'] = { query = '@function.outer', desc = 'Previous method/function definition end' },
          ['[O'] = { query = '@loop.outer', desc = 'Previous loop end' },
          ['[A'] = { query = '@parameter.inner', desc = 'Previous argument end' },
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ['>K'] = { query = '@block.outer', desc = 'Swap next block' },
          ['>F'] = { query = '@call.outer', desc = 'Swap next function call' },
          ['>M'] = { query = '@function.outer', desc = 'Swap next method/function definition' },
          ['>A'] = { query = '@parameter.inner', desc = 'Swap next argument' },
        },
        swap_previous = {
          ['<K'] = { query = '@block.outer', desc = 'Swap previous block' },
          ['<F'] = { query = '@call.outer', desc = 'Swap previous function call' },
          ['<M'] = { query = '@function.outer', desc = 'Swap previous method/function definition' },
          ['<A'] = { query = '@parameter.inner', desc = 'Swap previous argument' },
        },
      },
    },
    modules = {},
  })
end)

later(function()
  require('mini.extra').setup()
end)

later(function()
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

later(function()
  require('mini.bufremove').setup()
end)

later(function()
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
      -- Swap
      { mode = 'n', keys = '>' },
      { mode = 'n', keys = '<' },
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

later(function()
  require('mini.comment').setup({
    mappings = {
      comment = 'gc',
      comment_line = 'gcc',
      comment_visual = 'gc',
      textobject = 'igc',
    },
  })
end)

-- later(function()
--   require('mini.completion').setup({
--     source_func = 'omnifunc',
--     lsp_completion = {
--       process_items = function(items, base)
--         local processed_items = MiniCompletion.default_process_items(items, base)
--         return processed_items
--       end
--     }
--   })
--   vim.lsp.config('*', { capabilities = MiniCompletion.get_lsp_capabilities() })
-- end)

later(function()
  require('mini.cursorword').setup({
    delay = 0
  })
end)

later(function()
  require('mini.diff').setup({
    view = {
      style = 'sign',
      signs = { add = '▌', change = '▌', delete = '𝅋' },
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
end)

later(function()
  require('mini.files').setup({
    mappings = {
      go_in_plus = '<CR>'
    },
    options = {
      use_as_default_explorer = false,
    },
    windows = {
      preview = true
    }
  })
end)

later(function() require('mini.git').setup() end)

later(function()
  require('mini.indentscope').setup({
    draw = {
      delay = 0,
      animation = require('mini.indentscope').gen_animation.none(),
      predicate = function(scope) return scope.border.indent > 1 end
    },
    symbol = '▏'
  })
end)

-- later(function()
--   require('mini.jump2d').setup({
--     view = {
--       dim = true
--     },
--     allowed_windows = {
--       not_current = false,
--     },
--     silent = true
--   })
-- end)

later(function() require('mini.move').setup() end)

later(function()
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

  local is_array_of = function(x, ref_type)
    if not vim.islist(x) then return false end
    for i = 1, #x do
      if type(x[i]) ~= ref_type then return false end
    end
    return true
  end

  MiniPick.registry.grep_all_live = function(local_opts)
    local_opts = vim.tbl_extend('force', { globs = {} }, local_opts or {})

    local tool = 'rg'
    if vim.fn.executable(tool) ~= 1 then
      vim.notify('grep_live_all needs `rg` executable.', vim.log.levels.ERROR)
      return
    end

    local globs = is_array_of(local_opts.globs, 'string') and local_opts.globs or {}
    local name_suffix = #globs == 0 and '' or (' | ' .. table.concat(globs, ', '))

    local show = MiniPick.config.source.show or MiniPick.default_show
    local source = {
      name = string.format('Grep all live (%s%s)', tool, name_suffix),
      show = show,
      cwd = local_opts.cwd
    }

    local set_items_opts = { do_match = false, querytick = MiniPick.get_querytick() }
    local spawn_cwd = source.cwd or vim.fn.getcwd()
    local spawn_opts = { cwd = spawn_cwd }
    local process

    local get_rg_command = function(pattern, current_globs)
      local res = {
        'rg',
        '--column',
        '--line-number',
        '--no-heading',
        '--field-match-separator', '\\x00',
        '--color=never',
        '--hidden',
        '--no-ignore',
        '--glob', '!.git/*'
      }

      for _, g in ipairs(current_globs) do
        table.insert(res, '--glob')
        table.insert(res, g)
      end

      local case = vim.o.ignorecase and (vim.o.smartcase and 'smart-case' or 'ignore-case') or 'case-sensitive'
      table.insert(res, '--' .. case)

      table.insert(res, '--')
      table.insert(res, pattern)

      return res
    end

    local match = function(_, _, query)
      if process then pcall(vim.loop.process_kill, process) end
      set_items_opts.querytick = MiniPick.get_querytick()

      if #query == 0 then return MiniPick.set_picker_items({}, set_items_opts) end

      local pattern = table.concat(query)
      local command = get_rg_command(pattern, globs)

      process = MiniPick.set_picker_items_from_cli(command, {
        set_items_opts = set_items_opts,
        spawn_opts = spawn_opts
      })
    end

    local add_glob = function()
      local ok, glob = pcall(vim.fn.input, 'Glob pattern: ')
      if ok and glob ~= '' then
        table.insert(globs, glob)
        local new_suffix = #globs == 0 and '' or (' | ' .. table.concat(globs, ', '))
        MiniPick.set_picker_opts({
          source = { name = string.format('Grep All (%s%s)', tool, new_suffix) }
        })
        ---@diagnostic disable-next-line: param-type-mismatch
        MiniPick.set_picker_query(MiniPick.get_picker_query())
      end
    end

    local mappings = { add_glob = { char = '<C-o>', func = add_glob } }

    return MiniPick.start({
      source = { items = {}, match = match, name = source.name, show = source.show, cwd = source.cwd },
      mappings = mappings
    })
  end
end)

later(function()
  require('mini.snippets').setup({
    snippets = {
      -- require('mini.snippets').gen_loader.from_file(vim.fn.stdpath('config') .. '/snippets/global.json'),
      require('mini.snippets').gen_loader.from_lang({
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
  require('mini.surround').setup({
    silent = true
  })
end)

-- later(function()
--   require('blink.indent').setup({
--     static = {
--       -- enabled = true,
--       char = '▏'
--     },
--     scope = {
--       -- enabled = true,
--       char = '▏'
--     }
--   })
-- end)

later(function()
  require('blink.cmp').setup({
    keymap = {
      preset = 'none',
      ['<C-Space>'] = { 'show', 'show_documentation', 'hide_documentation' },
      ['<C-e>'] = { 'hide', 'fallback' },
      -- ['<CR>'] = { 'accept', 'fallback' },
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
    cmdline = { enabled = false },
    completion = {
      list = { selection = { preselect = true, auto_insert = false } },
      trigger = {
        prefetch_on_insert = false,
      },
      menu = {
        auto_show = function(ctx) return ctx.mode ~= 'cmdline' end,
        auto_show_delay_ms = 0,
        max_height = 12,
        scrollbar = true,
        -- winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None',
        draw = {
          -- treesitter = { 'lsp' },
          columns = {
            { 'kind_icon', 'label', 'kind', gap = 1 }, { 'label_description', gap = 1 }
          },
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
          -- winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None',
          border = 'padded'
        },
      },
    },
    snippets = { preset = 'mini_snippets' },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
    fuzzy = {
      implementation = 'rust',
      -- WARNING
      -- If you are using the Rust implementation but specify a custom Lua function for sorting,
      -- the sorting process will fall back to Lua instead of being handled by Rust.
      -- This can impact performance, particularly when working with large lists.
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
      trigger = {
        -- Show the signature help window after typing a trigger character
        show_on_trigger_character = false,
        -- Show the signature help window when the cursor comes after a trigger character when entering insert mode
        show_on_insert_on_trigger_character = false,
      },
      window = {
        border = 'solid',
        show_documentation = true,
        -- winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder',
      }
    }
  })
end)
