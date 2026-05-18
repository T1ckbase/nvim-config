---@type vim.lsp.Config
return {
  settings = {
    ['rust-analyzer'] = {
      check = { command = 'clippy' },
      checkOnSave = true,
      diagnostics = {
        styleLints = {
          enable = true,
        },
      },
    },
  },
}
