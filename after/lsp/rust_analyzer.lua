---@type vim.lsp.Config
return {
  settings = {
    ['rust-analyzer'] = {
      initialization_options = {
        check = {
          command = 'clippy'
        }
      }
    }
  }
}
