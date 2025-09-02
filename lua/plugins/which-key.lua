---@type LazySpec
return {
  'folke/which-key.nvim',
  -- The default priority for non-lazy plugins is 50.
  -- Setting this to 49 ensures the plugin loads slightly later than most others,
  -- without making it lazy-loaded.
  priority = 49,
  lazy = false,
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  keys = {
    {
      '<leader>?',
      function()
        require('which-key').show({ global = false })
      end,
      desc = 'Buffer Local Keymaps (which-key)',
    },
  },
}
