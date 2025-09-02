---@type LazySpec
return {
  'nvim-mini/mini.nvim',
  version = false,
  priority = 2000,
  lazy = false,
  init = function()
    package.preload['nvim-web-devicons'] = function()
      require('mini.icons').mock_nvim_web_devicons()
      return package.loaded['nvim-web-devicons']
    end
  end,
  config = function()
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

    require('mini.comment').setup({
      mappings = {
        comment = 'gc',
        comment_line = 'gcc',
        comment_visual = 'gc',
        textobject = 'igc',
      },
    })

    require('mini.diff').setup({
      view = {
        style = 'sign',
        signs = { add = '▎', change = '▎', delete = '▎' },
      },
      mappings = {
        apply = '',
        reset = '',
        textobject = '',
        goto_first = '[H',
        goto_prev = '[h',
        goto_next = ']h',
        goto_last = ']H',
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

    require('mini.sessions').setup({
      autoread = false,
      autowrite = false,
    })
    vim.api.nvim_create_autocmd('VimLeave', {
      group = vim.api.nvim_create_augroup('mini_sessions_auto_save', {}),
      pattern = '*',
      desc = 'Save current state to a default session before quitting',
      callback = function()
        if #vim.fn.getbufinfo({ buflisted = 1 }) == 0 then
          return
        end
        MiniSessions.write('LastSession', { force = true })
        -- MiniSessions.write(vim.fn.getcwd(), { force = true })
      end,
    })
    vim.keymap.set('n', '<leader>Sl', function() MiniSessions.read('LastSession') end, { desc = 'Load last session' })

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
          local filename    = "%{substitute(fnamemodify(expand('%'),':~:.'),'\\\\','/','g')}%m%r" -- MiniStatusline.section_filename({ trunc_width = 140 })
          local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75, icon = '', signs = { ERROR = '󰅚 ', WARN = '󰀪 ', INFO = '󰋽 ', HINT = '󰌶 ' } })
          local search      = MiniStatusline.section_searchcount({ trunc_width = 75 })
          local lsp         = MiniStatusline.section_lsp({ trunc_width = 75 })
          local fileinfo    = MiniStatusline.section_fileinfo({ trunc_width = 120 })
          local location    = MiniStatusline.section_location({ trunc_width = 75 })
          local percentage  = '%P'
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
  end,
}
