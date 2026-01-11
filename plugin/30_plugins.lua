local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
local now_if_args = vim.fn.argc(-1) > 0 and now or later

-- local customUtils = require('custom.utils')
-- customUtils.setup()

now(function()
  add('sainnhe/gruvbox-material')

  vim.g.gruvbox_material_foreground = 'mix'
  -- vim.g.gruvbox_material_background = 'hard'
  vim.g.gruvbox_material_diagnostic_virtual_text = 'colored'
  vim.cmd.colorscheme('gruvbox-material')

  vim.api.nvim_set_hl(0, 'CurSearch', { link = 'Search' })
  vim.api.nvim_set_hl(0, 'DiagnosticUnnecessary', { undercurl = true, sp = '#626262' })
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
        local diff = MiniStatusline.section_diff({ trunc_width = 75, icon = '' })
        local filename = (vim.bo.buftype == 'terminal' and '%t' or "%{expand('%:.')}%m%r") -- [[%{substitute(fnamemodify(expand('%'),':~:.'),'\\','/','g')}%m%r]] -- MiniStatusline.section_filename({ trunc_width = 140 })
        local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75, icon = '', signs = { ERROR = '󰅚 ', WARN = '󰀪 ', INFO = '󰋽 ', HINT = '󰌶 ' } })
        local search = MiniStatusline.section_searchcount({ trunc_width = 75 })
        local lsp = MiniStatusline.section_lsp({ trunc_width = 75 }) -- utils.status.lsp({ trunc_width = 100 }) -- MiniStatusline.section_lsp({ trunc_width = 75 })
        local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
        local location = MiniStatusline.section_location({ trunc_width = 75 })
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

now_if_args(function()
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
        local max_filesize = 10 * 1024 * 1024 -- 10 MB
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
          ['ac'] = { query = '@call.outer', desc = 'around function call' },
          ['ic'] = { query = '@call.inner', desc = 'inside function call' },
          ['aC'] = { query = '@class.outer', desc = 'around class' },
          ['iC'] = { query = '@class.inner', desc = 'inside class' },
          ['a?'] = { query = '@conditional.outer', desc = 'around conditional' },
          ['i?'] = { query = '@conditional.inner', desc = 'inside conditional' },
          ['af'] = { query = '@function.outer', desc = 'around method/function definition' },
          ['if'] = { query = '@function.inner', desc = 'inside method/function definition' },
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
          [']c'] = { query = '@call.outer', desc = 'Next function call start' },
          [']s'] = { query = '@class.outer', desc = 'Next class start' },
          [']?'] = { query = '@conditional.outer', desc = 'Next conditional start' },
          [']f'] = { query = '@function.outer', desc = 'Next method/function definition start' },
          [']o'] = { query = '@loop.outer', desc = 'Next loop start' },
          [']a'] = { query = '@parameter.inner', desc = 'Next argument start' },
        },
        goto_next_end = {
          [']K'] = { query = '@block.outer', desc = 'Next block end' },
          [']C'] = { query = '@call.outer', desc = 'Next function call end' },
          [']S'] = { query = '@class.outer', desc = 'Next class end' },
          [']F'] = { query = '@function.outer', desc = 'Next method/function definition end' },
          [']O'] = { query = '@loop.outer', desc = 'Next loop end' },
          [']A'] = { query = '@parameter.inner', desc = 'Next argument end' },
        },
        goto_previous_start = {
          ['[k'] = { query = '@block.outer', desc = 'Previous block start' },
          ['[c'] = { query = '@call.outer', desc = 'Previous function call start' },
          ['[s'] = { query = '@class.outer', desc = 'Previous class start' },
          ['[?'] = { query = '@conditional.outer', desc = 'Previous conditional start' },
          ['[f'] = { query = '@function.outer', desc = 'Previous method/function definition start' },
          ['[o'] = { query = '@loop.outer', desc = 'Previous loop start' },
          ['[a'] = { query = '@parameter.inner', desc = 'Previous argument start' },
        },
        goto_previous_end = {
          ['[K'] = { query = '@block.outer', desc = 'Previous block end' },
          ['[C'] = { query = '@call.outer', desc = 'Previous function call end' },
          ['[S'] = { query = '@class.outer', desc = 'Previous class end' },
          ['[F'] = { query = '@function.outer', desc = 'Previous method/function definition end' },
          ['[O'] = { query = '@loop.outer', desc = 'Previous loop end' },
          ['[A'] = { query = '@parameter.inner', desc = 'Previous argument end' },
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ['>K'] = { query = '@block.outer', desc = 'Swap next block' },
          ['>C'] = { query = '@call.outer', desc = 'Swap next function call' },
          ['>F'] = { query = '@function.outer', desc = 'Swap next method/function definition' },
          ['>A'] = { query = '@parameter.inner', desc = 'Swap next argument' },
        },
        swap_previous = {
          ['<K'] = { query = '@block.outer', desc = 'Swap previous block' },
          ['<C'] = { query = '@call.outer', desc = 'Swap previous function call' },
          ['<F'] = { query = '@function.outer', desc = 'Swap previous method/function definition' },
          ['<A'] = { query = '@parameter.inner', desc = 'Swap previous argument' },
        },
      },
    },
    modules = {},
  })

  local ts_repeat_move = require('nvim-treesitter.textobjects.repeatable_move')
  vim.keymap.set({ 'n', 'x', 'o' }, ';', ts_repeat_move.repeat_last_move)
  vim.keymap.set({ 'n', 'x', 'o' }, ',', ts_repeat_move.repeat_last_move_opposite)
  vim.keymap.set({ 'n', 'x', 'o' }, 'f', ts_repeat_move.builtin_f_expr, { expr = true })
  vim.keymap.set({ 'n', 'x', 'o' }, 'F', ts_repeat_move.builtin_F_expr, { expr = true })
  vim.keymap.set({ 'n', 'x', 'o' }, 't', ts_repeat_move.builtin_t_expr, { expr = true })
  vim.keymap.set({ 'n', 'x', 'o' }, 'T', ts_repeat_move.builtin_T_expr, { expr = true })
end)

now_if_args(function()
  add('neovim/nvim-lspconfig')

  vim.lsp.enable({
    'astro',
    'biome',
    'cssls',
    'denols',
    -- 'basedpyright',
    'emmet_language_server',
    'eslint',
    'html',
    'jsonls',
    'lua_ls',
    'markdown',
    'nushell',
    -- 'pyrefly',
    -- 'pyright',
    'ruff',
    'rust_analyzer',
    'svelte',
    -- 'stylua',
    -- 'tsgo',
    'ty',
    'vtsls',
    'yamlls',
    'zls'
  })
end)

-- Step two

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
      { mode = { 'n', 'x' }, keys = '<Leader>' },
      -- Bracket
      { mode = { 'n', 'x' }, keys = '[' },
      { mode = { 'n', 'x' }, keys = ']' },
      -- Built-in completion
      { mode = 'i',          keys = '<C-x>' },
      -- `g` key
      { mode = { 'n', 'x' }, keys = 'g' },
      -- Marks
      { mode = { 'n', 'x' }, keys = "'" },
      { mode = { 'n', 'x' }, keys = '`' },
      -- Registers
      { mode = { 'n', 'x' }, keys = '"' },
      { mode = { 'i', 'c' }, keys = '<C-r>' },
      -- Window commands
      { mode = 'n',          keys = '<C-w>' },
      -- `z` key
      { mode = { 'n', 'x' }, keys = 'z' },
      -- Text objects
      { mode = { 'o', 'x' }, keys = 'a' },
      { mode = { 'o', 'x' }, keys = 'i' },
      -- Swap
      { mode = 'n',          keys = '>' },
      { mode = 'n',          keys = '<' },
      -- mini.surround
      { mode = { 'n', 'x' }, keys = 's' },
    },
    clues = {
      -- Enhance this by adding descriptions for <Leader> mapping groups
      miniclue.gen_clues.square_brackets(),
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
  add('JoosepAlviste/nvim-ts-context-commentstring')

  require('mini.comment').setup({
    options = {
      custom_commentstring = function()
        return require('ts_context_commentstring').calculate_commentstring() or vim.bo.commentstring
      end,
    },
    mappings = {
      comment = 'gc',
      comment_line = 'gcc',
      comment_visual = 'gc',
      textobject = 'igc',
    },
  })
end)

-- later(function() -- Unable to remap <C-n>, <C-p>
--   require('mini.completion').setup({
--     lsp_completion = {
--       source_func = 'completefunc',
--       auto_setup = false,
--       process_items = function(items, base)
--         local processed_items = MiniCompletion.default_process_items(items, base, {
--           filtersort = 'prefix'
--         })
--         return processed_items
--       end,
--     },
--   })

--   vim.api.nvim_create_autocmd('LspAttach', {
--     group = 'custom-config',
--     callback = function(ev)
--       vim.bo[ev.buf].completefunc = 'v:lua.MiniCompletion.completefunc_lsp'
--     end,
--     desc = 'Set "completefunc" for mini.completion'
--   })

--   vim.lsp.config('*', { capabilities = MiniCompletion.get_lsp_capabilities() })
-- end)

-- later(function()
--   require('mini.cursorword').setup({
--     delay = 0
--   })
-- end)

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

later(function()
  require('mini.pick').setup({
    options = {
      use_cache = true
    },
    window = {
      config = function()
        local height = math.floor(0.618 * vim.o.lines)
        local width = math.floor(0.618 * vim.o.columns)
        return {
          anchor = 'NW',
          height = height,
          width = width,
          row = math.floor(0.5 * (vim.o.lines - height)),
          col = math.floor(0.5 * (vim.o.columns - width)),
        }
      end
    }
  })

  MiniPick.registry.files = function(local_opts)
    local_opts = vim.tbl_deep_extend('force', {
      hidden = false,
      ignored = false,
    }, local_opts or {})

    local command = { 'rg', '--files', '--color=never', '--glob', '!.git/*' }

    if local_opts.hidden then
      table.insert(command, '--hidden')
    end

    if local_opts.ignored then
      table.insert(command, '--no-ignore')
    end

    return MiniPick.builtin.cli(
      {
        command = command
      },
      {
        source = {
          name = string.format('Files (rg%s%s)',
            local_opts.hidden and ' --hidden' or '',
            local_opts.ignored and ' --no-ignore' or ''),
          show = function(buf_id, items, query)
            MiniPick.default_show(buf_id, items, query, { show_icons = true })
          end
        }
      }
    )
  end

  MiniPick.registry.grep_live = function(local_opts)
    local_opts = vim.tbl_deep_extend('force', { hidden = false, ignored = false }, local_opts or {})
    local user_globs = {}

    local get_name = function()
      local name = string.format('Grep Live (rg%s%s)',
        local_opts.hidden and ' --hidden' or '',
        local_opts.ignored and ' --no-ignore' or '')
      return #user_globs > 0 and (name .. ' | ' .. table.concat(user_globs, ', ')) or name
    end

    local build_rg_command = function(pattern)
      local cmd = {
        'rg', '--column', '--line-number', '--no-heading',
        '--field-match-separator', '\\x00', '--color=never',
        '--glob', '!.git/*',
      }

      if local_opts.hidden then table.insert(cmd, '--hidden') end
      if local_opts.ignored then table.insert(cmd, '--no-ignore') end

      local case = vim.o.ignorecase and (vim.o.smartcase and 'smart-case' or 'ignore-case') or 'case-sensitive'
      table.insert(cmd, '--' .. case)

      for _, g in ipairs(user_globs) do
        table.insert(cmd, '--glob')
        table.insert(cmd, g)
      end

      vim.list_extend(cmd, { '--', pattern })
      return cmd
    end

    local set_items_opts = { do_match = false, querytick = MiniPick.get_querytick() }
    local process
    local match = function(_, _, query)
      if process then pcall(vim.loop.process_kill, process) end
      if MiniPick.get_querytick() == set_items_opts.querytick then return end
      if #query == 0 then return MiniPick.set_picker_items({}, set_items_opts) end

      set_items_opts.querytick = MiniPick.get_querytick()
      process = MiniPick.set_picker_items_from_cli(build_rg_command(table.concat(query)), {
        set_items_opts = set_items_opts,
        spawn_opts = { cwd = MiniPick.get_picker_opts().source.cwd }
      })
    end

    local add_glob = function()
      local ok, glob = pcall(vim.fn.input, 'Glob pattern: ')
      if ok and glob ~= '' then
        table.insert(user_globs, glob)
        MiniPick.set_picker_opts({ source = { name = get_name() } })
        ---@diagnostic disable-next-line: param-type-mismatch
        MiniPick.set_picker_query(MiniPick.get_picker_query())
      end
    end

    return MiniPick.start({
      source = {
        name = get_name(),
        items = {},
        match = match,
        show = function(buf_id, items, query)
          MiniPick.default_show(buf_id, items, query, { show_icons = true })
        end,
      },
      mappings = { add_glob = { char = '<C-o>', func = add_glob } }
    })
  end

  MiniPick.registry.lsp_jump = function(local_opts, opts)
    local_opts = local_opts or {}
    local scope = local_opts.scope or 'definition'

    local function jump_to_item(item)
      local bufnr = item.bufnr
      if not (bufnr and vim.api.nvim_buf_is_valid(bufnr)) then
        bufnr = vim.fn.bufadd(item.filename)
      end

      local from = { vim.fn.bufnr('%'), vim.fn.line('.'), vim.fn.col('.'), 0 }
      local tagname = vim.fn.expand('<cword>')
      vim.fn.settagstack(vim.fn.win_getid(0), { items = { { tagname = tagname, from = from } } }, 't')

      vim.cmd("normal! m'")

      vim.api.nvim_set_current_buf(bufnr)
      vim.api.nvim_win_set_cursor(0, { item.lnum, item.col - 1 })
      vim.cmd('normal! zv')
    end

    local on_list = function(options)
      local items = options.items or {}
      if #items == 1 then
        jump_to_item(items[1])
      else
        MiniExtra.pickers.lsp(local_opts, opts)
      end
    end

    if scope == 'references' then
      vim.lsp.buf.references(nil, { on_list = on_list })
    elseif scope == 'workspace_symbol' then
      vim.lsp.buf.workspace_symbol(local_opts.symbol_query or '', { on_list = on_list })
    elseif vim.tbl_contains({ 'declaration', 'definition', 'implementation', 'type_definition', 'document_symbol' }, scope) then
      if vim.lsp.buf[scope] then
        vim.lsp.buf[scope]({ on_list = on_list })
      else
        vim.notify('LSP method not supported: ' .. scope, vim.log.levels.ERROR)
      end
    else
      MiniExtra.pickers.lsp(local_opts, opts)
    end
  end
end)

later(function()
  add('T1ckbase/vscode-snippets')

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

later(function()
  add({
    source = 'saghen/blink.cmp',
    checkout = 'v1.8.0', -- https://github.com/nvim-mini/mini.nvim/discussions/1896
  })

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
        function(a, b) -- depriority emmet_language_server
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
      }
    }
  })
end)

later(function()
  add('akinsho/toggleterm.nvim')

  require('toggleterm').setup({
    open_mapping = [[<M-i>]],
    direction = 'tab',
    start_in_insert = true,
  })
end)
