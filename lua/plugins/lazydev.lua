---@type LazySpec
return {
  'folke/lazydev.nvim',
  ft = 'lua',
  cmd = 'LazyDev',
  opts_extend = { 'library' },
  opts = {
    library = {
      { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      { path = 'lazy.nvim',          words = { 'Lazy' } },
    },
  },
  specs = {
    {
      'Saghen/blink.cmp',
      optional = true,
      opts = {
        sources = {
          default = { 'lazydev' },
          providers = {
            lazydev = { name = 'LazyDev', module = 'lazydev.integrations.blink', score_offset = 100 },
          },
        },
      },
    },
  },
}
