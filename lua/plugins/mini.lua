---@type LazySpec
return {
  'echasnovski/mini.nvim',
  version = '*',
  config = function()
    require('mini.ai').setup({
      mappings = {
        around_next = '',
        inside_next = '',
        around_last = '',
        inside_last = '',
        goto_left   = '',
        goto_right  = '',
      }
    })

    require('mini.comment').setup()

    require('mini.pairs').setup()
  end,
}
