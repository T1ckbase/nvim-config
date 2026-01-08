---@type vim.lsp.Config
return {
  settings = {
    deno = {
      suggest = {
        imports = {
          hosts = {
            ['https://deno.land'] = false
          }
        },
      },
    },
  },
  -- https://github.com/neovim/nvim-lspconfig/issues/3728#issuecomment-2966741537
  workspace_required = true,
}
