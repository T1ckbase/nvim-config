---@type LazySpec
return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    -- bigfile = { enabled = true },
    -- dashboard = { enabled = true },
    -- explorer = { enabled = true },
    -- image = { enabled = true },
    indent = {
      enabled = false,
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
      layout = 'my_layout2',
      layouts = {
        my_layout = {
          layout = {
            box = 'horizontal',
            backdrop = false,
            -- width = 0.8,
            -- height = 0.9,
            border = 'single',
            {
              box = 'vertical',
              { win = 'input', height = 1,          border = 'bottom',    title = '{title} {live} {flags}', title_pos = 'center' },
              { win = 'list',  title = ' Results ', title_pos = 'center', border = 'none' },
            },
            {
              win = 'preview',
              title = '{preview:Preview}',
              width = 0.45,
              border = 'left',
              title_pos = 'center',
            },
          },
        },
        my_layout2 = {
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
    notifier = { enabled = true },
    -- quickfile = { enabled = true },
    scope = { enabled = true },
    -- scroll = { enabled = true },
    -- statuscolumn = { enabled = true },
    -- words = { enabled = true },
  },
  keys = {
    { '<leader>fb', function() Snacks.picker.buffers() end, desc = 'Find Buffers' },
    { '<leader>ff', function() Snacks.picker.files() end,   desc = 'Find Files' },
    {
      '<leader>fF',
      function() Snacks.picker.files({ hidden = true, ignored = true }) end,
      desc = 'Find all files'
    },
    { '<leader>fw', function() Snacks.picker.grep() end,                 desc = 'Find Words' },
    {
      '<leader>fW',
      function() Snacks.picker.grep({ hidden = true, ignored = true }) end,
      desc = 'Find words in all files',
    },
    { '<leader>ft', function() Snacks.picker.colorschemes() end,         desc = 'Colorschemes' },
    { '<leader>fk', function() Snacks.picker.keymaps() end,              desc = 'Find keymaps' },
    -- { '<leader>z',  function() Snacks.zen() end,                 desc = 'Toggle Zen Mode' },

    { 'gd',         function() Snacks.picker.lsp_definitions() end,      desc = 'Goto Definition' },
    { 'gD',         function() Snacks.picker.lsp_declarations() end,     desc = 'Goto Declaration' },
    { 'gy',         function() Snacks.picker.lsp_type_definitions() end, desc = 'Goto T[y]pe Definition' },
  }
}
