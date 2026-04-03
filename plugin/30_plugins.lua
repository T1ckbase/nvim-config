local now = function(f) require('mini.misc').safely('now', f) end
local later = function(f) require('mini.misc').safely('later', f) end
local now_if_args = vim.fn.argc(-1) > 0 and now or later

-- local customUtils = require('custom.utils')
-- customUtils.setup()

now(function()
  vim.pack.add({ 'https://github.com/sainnhe/gruvbox-material' })

  vim.g.gruvbox_material_foreground = 'mix'
  -- vim.g.gruvbox_material_background = 'hard'
  vim.g.gruvbox_material_diagnostic_virtual_text = 'colored'
  vim.cmd.colorscheme('gruvbox-material')

  vim.api.nvim_set_hl(0, 'CurSearch', { link = 'Search' })

  if vim.g.neovide then
    vim.api.nvim_set_hl(0, 'DiagnosticUnnecessary', { undercurl = true, sp = '#626262' })
  else
    vim.api.nvim_set_hl(0, 'DiagnosticUnnecessary', { dim = true })
  end
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
    },
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
        local filename = (vim.bo.buftype == 'terminal' and '%t' or "%{expand('%:.')}%m%r") -- MiniStatusline.section_filename({ trunc_width = 140 })
        local diagnostics = MiniStatusline.section_diagnostics({
          trunc_width = 75,
          icon = '',
          signs = { ERROR = '󰅚 ', WARN = '󰀪 ', INFO = '󰋽 ', HINT = '󰌶 ' },
        })
        local search = MiniStatusline.section_searchcount({ trunc_width = 75 })
        local lsp = MiniStatusline.section_lsp({ trunc_width = 75 }) -- utils.status.lsp({ trunc_width = 100 }) -- MiniStatusline.section_lsp({ trunc_width = 75 })
        local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
        local location = MiniStatusline.section_location({ trunc_width = 75 })
        local percentage = '%P'

        return MiniStatusline.combine_groups({
          { hl = mode_hl, strings = { mode } },
          { hl = 'MiniStatuslineDevinfo', strings = { git, diff } },
          '%<',
          { hl = 'MiniStatuslineFilename', strings = { filename } },
          { hl = 'MiniStatuslineDevinfo', strings = { diagnostics } },
          '%=',
          { hl = 'MiniStatuslineDevinfo', strings = { search } },
          '%=',
          { hl = 'MiniStatuslineDevinfo', strings = { lsp } },
          { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
          { hl = mode_hl, strings = { location, percentage } },
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
    tabpage_section = 'right',
  })
end)

now_if_args(function()
  vim.pack.add({
    'https://github.com/nvim-treesitter/nvim-treesitter',
    'https://github.com/nvim-treesitter/nvim-treesitter-textobjects',
  })

  local languages = {
    'astro',
    'bash',
    'c',
    'cmake',
    'cpp',
    'css',
    'csv',
    'cuda',
    'diff',
    'dockerfile',
    'editorconfig',
    'git_config',
    'git_rebase',
    'gitattributes',
    'gitcommit',
    'gitignore',
    'glsl',
    'go',
    'hlsl',
    'html',
    'html_tags',
    'javascript',
    'jsdoc',
    'json',
    'json5',
    'jsx',
    'just',
    'lua',
    'luadoc',
    'make',
    'markdown',
    'markdown_inline',
    'ninja',
    'nu',
    'printf',
    'python',
    'regex',
    'rust',
    'scss',
    'sql',
    'squirrel',
    'svelte',
    'toml',
    'tsx',
    'typescript',
    'vim',
    'vimdoc',
    'wgsl',
    'xml',
    'yaml',
    'zig',
  }

  require('nvim-treesitter').install(languages)

  local filetypes = {}
  for _, lang in ipairs(languages) do
    for _, ft in ipairs(vim.treesitter.language.get_filetypes(lang)) do
      table.insert(filetypes, ft)
    end
  end

  vim.api.nvim_create_autocmd('FileType', {
    group = 'custom-config',
    pattern = filetypes,
    callback = function(args)
      local ok, err = pcall(vim.treesitter.start, args.buf)

      if ok then
        vim.opt_local.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.opt_local.foldmethod = 'expr'
        vim.bo[args.buf].indentexpr = 'v:lua.require("nvim-treesitter").indentexpr()'
      else
        vim.notify(('treesitter failed for buffer %d: %s'):format(args.buf, err), vim.log.levels.WARN)
      end
    end,
  })

  require('nvim-treesitter-textobjects').setup({
    select = {
      lookahead = true,
    },
    move = {
      set_jumps = true,
    },
  })

  local ts_select = function(query) require('nvim-treesitter-textobjects.select').select_textobject(query, 'textobjects') end
  local ts_move = function(method, query) require('nvim-treesitter-textobjects.move')[method](query, 'textobjects') end
  local ts_swap = function(method, query) require('nvim-treesitter-textobjects.swap')[method](query) end

  vim.keymap.set({ 'x', 'o' }, 'ak', function() ts_select('@block.outer') end, { desc = 'Around block' })
  vim.keymap.set({ 'x', 'o' }, 'ik', function() ts_select('@block.inner') end, { desc = 'Inside block' })
  vim.keymap.set({ 'x', 'o' }, 'ac', function() ts_select('@call.outer') end, { desc = 'Around function call' })
  vim.keymap.set({ 'x', 'o' }, 'ic', function() ts_select('@call.inner') end, { desc = 'Inside function call' })
  vim.keymap.set({ 'x', 'o' }, 'as', function() ts_select('@class.outer') end, { desc = 'Around class' })
  vim.keymap.set({ 'x', 'o' }, 'is', function() ts_select('@class.inner') end, { desc = 'Inside class' })
  vim.keymap.set({ 'x', 'o' }, 'af', function() ts_select('@function.outer') end, { desc = 'Around method/function definition' })
  vim.keymap.set({ 'x', 'o' }, 'if', function() ts_select('@function.inner') end, { desc = 'Inside method/function definition' })
  vim.keymap.set({ 'x', 'o' }, 'ao', function() ts_select('@loop.outer') end, { desc = 'Around loop' })
  vim.keymap.set({ 'x', 'o' }, 'io', function() ts_select('@loop.inner') end, { desc = 'Inside loop' })
  vim.keymap.set({ 'x', 'o' }, 'aa', function() ts_select('@parameter.outer') end, { desc = 'Around argument' })
  vim.keymap.set({ 'x', 'o' }, 'ia', function() ts_select('@parameter.inner') end, { desc = 'Inside argument' })
  vim.keymap.set({ 'x', 'o' }, 'a?', function() ts_select('@conditional.outer') end, { desc = 'Around conditional' })
  vim.keymap.set({ 'x', 'o' }, 'i?', function() ts_select('@conditional.inner') end, { desc = 'Inside conditional' })

  vim.keymap.set({ 'n', 'x', 'o' }, ']k', function() ts_move('goto_next_start', '@block.outer') end, { desc = 'Next block start' })
  vim.keymap.set({ 'n', 'x', 'o' }, ']c', function() ts_move('goto_next_start', '@call.outer') end, { desc = 'Next function call start' })
  vim.keymap.set({ 'n', 'x', 'o' }, ']s', function() ts_move('goto_next_start', '@class.outer') end, { desc = 'Next class start' })
  vim.keymap.set({ 'n', 'x', 'o' }, ']f', function() ts_move('goto_next_start', '@function.outer') end, { desc = 'Next method/function definition start' })
  vim.keymap.set({ 'n', 'x', 'o' }, ']o', function() ts_move('goto_next_start', '@loop.outer') end, { desc = 'Next loop start' })
  vim.keymap.set({ 'n', 'x', 'o' }, ']a', function() ts_move('goto_next_start', '@parameter.inner') end, { desc = 'Next argument start' })
  vim.keymap.set({ 'n', 'x', 'o' }, ']?', function() ts_move('goto_next_start', '@conditional.outer') end, { desc = 'Next conditional start' })

  vim.keymap.set({ 'n', 'x', 'o' }, ']K', function() ts_move('goto_next_end', '@block.outer') end, { desc = 'Next block end' })
  vim.keymap.set({ 'n', 'x', 'o' }, ']C', function() ts_move('goto_next_end', '@call.outer') end, { desc = 'Next function call end' })
  vim.keymap.set({ 'n', 'x', 'o' }, ']S', function() ts_move('goto_next_end', '@class.outer') end, { desc = 'Next class end' })
  vim.keymap.set({ 'n', 'x', 'o' }, ']F', function() ts_move('goto_next_end', '@function.outer') end, { desc = 'Next method/function definition end' })
  vim.keymap.set({ 'n', 'x', 'o' }, ']O', function() ts_move('goto_next_end', '@loop.outer') end, { desc = 'Next loop end' })
  vim.keymap.set({ 'n', 'x', 'o' }, ']A', function() ts_move('goto_next_end', '@parameter.inner') end, { desc = 'Next argument end' })

  vim.keymap.set({ 'n', 'x', 'o' }, '[k', function() ts_move('goto_previous_start', '@block.outer') end, { desc = 'Previous block start' })
  vim.keymap.set({ 'n', 'x', 'o' }, '[c', function() ts_move('goto_previous_start', '@call.outer') end, { desc = 'Previous function call start' })
  vim.keymap.set({ 'n', 'x', 'o' }, '[s', function() ts_move('goto_previous_start', '@class.outer') end, { desc = 'Previous class start' })
  vim.keymap.set({ 'n', 'x', 'o' }, '[f', function() ts_move('goto_previous_start', '@function.outer') end, { desc = 'Previous method/function definition start' })
  vim.keymap.set({ 'n', 'x', 'o' }, '[o', function() ts_move('goto_previous_start', '@loop.outer') end, { desc = 'Previous loop start' })
  vim.keymap.set({ 'n', 'x', 'o' }, '[a', function() ts_move('goto_previous_start', '@parameter.inner') end, { desc = 'Previous argument start' })
  vim.keymap.set({ 'n', 'x', 'o' }, '[?', function() ts_move('goto_previous_start', '@conditional.outer') end, { desc = 'Previous conditional start' })

  vim.keymap.set({ 'n', 'x', 'o' }, '[K', function() ts_move('goto_previous_end', '@block.outer') end, { desc = 'Previous block end' })
  vim.keymap.set({ 'n', 'x', 'o' }, '[C', function() ts_move('goto_previous_end', '@call.outer') end, { desc = 'Previous function call end' })
  vim.keymap.set({ 'n', 'x', 'o' }, '[S', function() ts_move('goto_previous_end', '@class.outer') end, { desc = 'Previous class end' })
  vim.keymap.set({ 'n', 'x', 'o' }, '[F', function() ts_move('goto_previous_end', '@function.outer') end, { desc = 'Previous method/function definition end' })
  vim.keymap.set({ 'n', 'x', 'o' }, '[O', function() ts_move('goto_previous_end', '@loop.outer') end, { desc = 'Previous loop end' })
  vim.keymap.set({ 'n', 'x', 'o' }, '[A', function() ts_move('goto_previous_end', '@parameter.inner') end, { desc = 'Previous argument end' })

  vim.keymap.set('n', '>K', function() ts_swap('swap_next', '@block.outer') end, { desc = 'Swap next block' })
  vim.keymap.set('n', '>C', function() ts_swap('swap_next', '@call.outer') end, { desc = 'Swap next function call' })
  vim.keymap.set('n', '>S', function() ts_swap('swap_next', '@class.outer') end, { desc = 'Swap next class' })
  vim.keymap.set('n', '>F', function() ts_swap('swap_next', '@function.outer') end, { desc = 'Swap next method/function definition' })
  vim.keymap.set('n', '>O', function() ts_swap('swap_next', '@loop.outer') end, { desc = 'Swap next loop' })
  vim.keymap.set('n', '>A', function() ts_swap('swap_next', '@parameter.inner') end, { desc = 'Swap next argument' })

  vim.keymap.set('n', '<lt>K', function() ts_swap('swap_previous', '@block.outer') end, { desc = 'Swap previous block' })
  vim.keymap.set('n', '<lt>C', function() ts_swap('swap_previous', '@call.outer') end, { desc = 'Swap previous function call' })
  vim.keymap.set('n', '<lt>S', function() ts_swap('swap_previous', '@class.outer') end, { desc = 'Swap previous class' })
  vim.keymap.set('n', '<lt>F', function() ts_swap('swap_previous', '@function.outer') end, { desc = 'Swap previous method/function definition' })
  vim.keymap.set('n', '<lt>O', function() ts_swap('swap_previous', '@loop.outer') end, { desc = 'Swap previous loop' })
  vim.keymap.set('n', '<lt>A', function() ts_swap('swap_previous', '@parameter.inner') end, { desc = 'Swap previous argument' })

  local ts_repeat_move = require('nvim-treesitter-textobjects.repeatable_move')
  vim.keymap.set({ 'n', 'x', 'o' }, ';', ts_repeat_move.repeat_last_move, { desc = 'Repeat last move' })
  vim.keymap.set({ 'n', 'x', 'o' }, ',', ts_repeat_move.repeat_last_move_opposite, { desc = 'Repeat last move opposite' })
  vim.keymap.set({ 'n', 'x', 'o' }, 'f', ts_repeat_move.builtin_f_expr, { expr = true, desc = 'Repeatable f' })
  vim.keymap.set({ 'n', 'x', 'o' }, 'F', ts_repeat_move.builtin_F_expr, { expr = true, desc = 'Repeatable F' })
  vim.keymap.set({ 'n', 'x', 'o' }, 't', ts_repeat_move.builtin_t_expr, { expr = true, desc = 'Repeatable t' })
  vim.keymap.set({ 'n', 'x', 'o' }, 'T', ts_repeat_move.builtin_T_expr, { expr = true, desc = 'Repeatable T' })
end)

now_if_args(function()
  vim.pack.add({ 'https://github.com/neovim/nvim-lspconfig' })

  vim.lsp.enable({
    'astro',
    'biome',
    'cssls',
    'clangd',
    'denols',
    'emmet_language_server',
    'eslint',
    'html',
    'jsonls',
    'lua_ls',
    'markdown',
    'nushell',
    'oxfmt',
    'oxlint',
    -- 'pyrefly',
    -- 'pyright',
    'ruff',
    'rust_analyzer',
    'stylua',
    'svelte',
    -- 'tsgo',
    'ty',
    'vtsls',
    'yamlls',
    'zls',
  })

  vim.lsp.document_color.enable(true, nil, { style = 'virtual' })
  vim.lsp.inline_completion.enable(true, nil)
end)

-- Step two

later(function()
  vim.cmd.packadd('nvim.difftool')
  vim.cmd.packadd('nvim.undotree')
end)

later(function() require('mini.extra').setup() end)

later(function()
  require('mini.ai').setup({
    custom_textobjects = {
      b = false,
      f = false,
      a = false,
      ['?'] = false,
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
    silent = true,
  })
end)

later(function() require('mini.bufremove').setup() end)

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
      { mode = 'i', keys = '<C-x>' },
      -- `g` key
      { mode = { 'n', 'x' }, keys = 'g' },
      -- Marks
      { mode = { 'n', 'x' }, keys = "'" },
      { mode = { 'n', 'x' }, keys = '`' },
      -- Registers
      { mode = { 'n', 'x' }, keys = '"' },
      { mode = { 'i', 'c' }, keys = '<C-r>' },
      -- Window commands
      { mode = 'n', keys = '<C-w>' },
      -- `z` key
      { mode = { 'n', 'x' }, keys = 'z' },
      -- Text objects
      { mode = { 'o', 'x' }, keys = 'a' },
      { mode = { 'o', 'x' }, keys = 'i' },
      -- Swap
      { mode = 'n', keys = '>' },
      { mode = 'n', keys = '<' },
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
        width = 42,
      },
    },
  })
end)

later(function()
  vim.pack.add({ 'https://github.com/folke/ts-comments.nvim' })

  require('ts-comments').setup()

  require('mini.comment').setup({
    mappings = {
      comment = '',
      comment_line = '',
      comment_visual = '',
      textobject = 'igc',
    },
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
      textobject = 'gh',
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
      go_in_plus = '<CR>',
    },
    options = {
      use_as_default_explorer = false,
    },
    windows = {
      preview = false,
    },
  })

  vim.api.nvim_create_autocmd('User', {
    group = 'custom-config',
    pattern = 'MiniFilesWindowOpen',
    callback = function(args)
      local win_id = args.data.win_id
      local config = vim.api.nvim_win_get_config(win_id)
      config.border = 'solid'
      vim.api.nvim_win_set_config(win_id, config)
    end,
  })
end)

later(function() require('mini.git').setup() end)

later(function()
  require('mini.indentscope').setup({
    draw = {
      delay = 0,
      animation = require('mini.indentscope').gen_animation.none(),
      predicate = function(scope) return scope.border.indent > 1 end,
    },
    symbol = '▏',
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

later(
  function()
    require('mini.pairs').setup({
      mappings = {
        ['"'] = {
          action = 'closeopen',
          pair = '""',
          neigh_pattern = '^[\r%s%(%[%{,][%s\n%)%]%},]',
          register = { cr = false },
        },
        ["'"] = {
          action = 'closeopen',
          pair = "''",
          neigh_pattern = '^[\r%s%(%[%{,][%s\n%)%]%},]',
          register = { cr = false },
        },
        ['`'] = {
          action = 'closeopen',
          pair = '``',
          neigh_pattern = '[^\\][%s\n%)%]%},]',
          register = { cr = false },
        },
      },
    })
  end
)

later(function()
  require('mini.pick').setup({
    options = {
      use_cache = true,
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
          border = 'solid',
        }
      end,
    },
  })

  MiniPick.registry.files = function(local_opts)
    local_opts = vim.tbl_deep_extend('force', { hidden = false, ignored = false }, local_opts or {})

    local command = { 'fd', '--type=f', '--color=never' }

    if local_opts.hidden then vim.list_extend(command, { '--hidden', '--exclude', '.git/*' }) end

    if local_opts.ignored then table.insert(command, '--no-ignore') end

    return MiniPick.builtin.cli({
      command = command,
    }, {
      source = {
        name = string.format('Files (fd%s%s)', local_opts.hidden and ' --hidden' or '', local_opts.ignored and ' --no-ignore' or ''),
        show = function(buf_id, items, query) MiniPick.default_show(buf_id, items, query, { show_icons = true }) end,
      },
    })
  end

  MiniPick.registry.grep_live = function(local_opts)
    local_opts = vim.tbl_deep_extend('force', { hidden = false, ignored = false }, local_opts or {})
    local user_globs = {}

    local get_name = function()
      local name = string.format('Grep Live (rg%s%s)', local_opts.hidden and ' --hidden' or '', local_opts.ignored and ' --no-ignore' or '')
      return #user_globs > 0 and (name .. ' | ' .. table.concat(user_globs, ', ')) or name
    end

    local build_rg_command = function(pattern)
      local cmd = {
        'rg',
        '--column',
        '--line-number',
        '--no-heading',
        '--field-match-separator',
        '\\x00',
        '--color=never',
      }

      if local_opts.hidden then vim.list_extend(cmd, { '--hidden', '--glob', '!.git/*' }) end

      if local_opts.ignored then table.insert(cmd, '--no-ignore') end

      local case = vim.o.ignorecase and (vim.o.smartcase and 'smart-case' or 'ignore-case') or 'case-sensitive'
      table.insert(cmd, '--' .. case)

      for _, g in ipairs(user_globs) do
        vim.list_extend(cmd, { '--glob', g })
      end

      vim.list_extend(cmd, { '--', pattern })
      return cmd
    end

    local set_items_opts = { do_match = false, querytick = MiniPick.get_querytick() }
    local sys = { kill = function() end }
    local match = function(_, _, query)
      sys:kill()
      if MiniPick.get_querytick() == set_items_opts.querytick then return end
      if #query == 0 then
        sys = { kill = function() end }
        return MiniPick.set_picker_items({}, set_items_opts)
      end

      set_items_opts.querytick = MiniPick.get_querytick()
      ---@diagnostic disable-next-line: cast-local-type
      sys = MiniPick.set_picker_items_from_cli(build_rg_command(table.concat(query)), {
        set_items_opts = set_items_opts,
        spawn_opts = { cwd = MiniPick.get_picker_opts().source.cwd },
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
        show = function(buf_id, items, query) MiniPick.default_show(buf_id, items, query, { show_icons = true }) end,
      },
      mappings = { add_glob = { char = '<C-o>', func = add_glob } },
    })
  end

  MiniPick.registry.lsp_jump = function(local_opts)
    local_opts = local_opts or {}
    local scope = local_opts.scope

    if not scope then
      vim.notify('lsp_jump: scope is required', vim.log.levels.ERROR)
      return
    end

    if not vim.tbl_contains({ 'declaration', 'definition', 'type_definition' }, scope) then
      vim.notify('lsp_jump: invalid scope: ' .. scope, vim.log.levels.ERROR)
      return
    end

    -- Capture before request
    local bufnr = vim.api.nvim_get_current_buf()
    local win = vim.api.nvim_get_current_win()
    local from = vim.fn.getpos('.')
    from[1] = bufnr
    local tagname = vim.fn.expand('<cword>')

    local function jump_to_item(item)
      local b = item.bufnr
      if not (b and vim.api.nvim_buf_is_valid(b)) then b = vim.fn.bufadd(item.filename) end

      vim.cmd("normal! m'")
      vim.fn.settagstack(vim.fn.win_getid(win), { items = { { tagname = tagname, from = from } } }, 't')

      vim.bo[b].buflisted = true
      vim.api.nvim_set_current_buf(b)
      vim.api.nvim_win_set_cursor(0, { item.lnum, item.col - 1 })
      vim.cmd('normal! zv')
    end

    local on_list = function(options)
      local items = options.items or {}
      if #items == 0 then
        vim.notify('No locations found', vim.log.levels.INFO)
      elseif #items == 1 then
        jump_to_item(items[1])
      else
        MiniExtra.pickers.lsp(local_opts)
      end
    end

    vim.lsp.buf[scope]({ on_list = on_list })
  end
end)

later(function()
  vim.pack.add({ 'https://github.com/T1ckbase/vscode-snippets' })

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
        },
      }),
    },
    mappings = {
      expand = '',
      jump_next = '',
      jump_prev = '',
      stop = '<C-c>',
    },
    expand = {
      insert = function(snippet, _) vim.snippet.expand(snippet.body) end,
    },
  })
  -- MiniSnippets.start_lsp_server()
end)

later(function()
  require('mini.surround').setup({
    silent = true,
  })
end)

later(function()
  vim.pack.add({
    {
      src = 'https://github.com/saghen/blink.cmp',
      version = vim.version.range('^1'),
    },
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
        'fallback',
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
            { 'kind_icon' },
            { 'label', 'label_description', gap = 1 },
            { 'kind' },
          },
          components = {
            kind_icon = {
              text = function(ctx)
                local kind_icon, _, _ = MiniIcons.get('lsp', ctx.kind)
                return kind_icon .. ctx.icon_gap
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
            },
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
          border = 'padded',
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
          if (a.client_name == nil or b.client_name == nil) or (a.client_name == b.client_name) then return end
          return b.client_name == 'emmet_language_server'
        end,
        -- default sorts
        'score',
        'sort_text',
      },
      frecency = {
        enabled = false,
      },
      use_proximity = false,
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
      },
    },
  })
end)

later(function()
  vim.pack.add({ 'https://github.com/akinsho/toggleterm.nvim' })

  require('toggleterm').setup({
    open_mapping = [[<M-i>]],
    direction = 'tab',
    start_in_insert = true,
    shell = 'nu',
  })
end)

-- later(function()
--   add({
--     name = 'mini-files-git-status',
--     checkout = 'HEAD',
--   })
--
--   local mfgs = require('t1ckbase.mini-files-git-status')
--   mfgs.setup({
--     display_mode = 'virt_text',
--     status_map = {
--       ['--'] = { icon = '' },
--       ['-N'] = { hl = 'NeoTreeGitAdded' },
--       ['-M'] = { hl = 'NeoTreeGitModified' },
--       ['-D'] = { hl = 'NeoTreeGitDeleted' },
--       ['-R'] = { hl = 'NeoTreeGitRenamed' },
--       ['-T'] = { hl = 'NeoTreeGitModified' },
--       ['-I'] = { hl = 'NeoTreeGitIgnored' },
--       ['-U'] = { hl = 'NeoTreeGitConflict' },
--     },
--   })
--
--   mfgs.update_cache(vim.fn.getcwd())
-- end)

later(function ()
  vim.opt.runtimepath:prepend('C:/Users/nah/code/archive/supermaven-language-server')
  vim.lsp.enable('supermaven')
end)
