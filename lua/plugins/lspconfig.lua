-- if true then return {} end

---@type LazySpec
return {
  'neovim/nvim-lspconfig',
  lazy = false,
  dependencies = {
    'saghen/blink.cmp',
  },
  config = function()
    require('config.lsp')
  end
}
