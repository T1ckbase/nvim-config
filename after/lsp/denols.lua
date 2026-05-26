---@type vim.lsp.Config
return {
  ---@type lspconfig.settings.denols
  settings = {
    deno = {
      suggest = {
        imports = {
          hosts = {
            ['https://deno.land'] = false,
          },
        },
      },
    },
  },
}
