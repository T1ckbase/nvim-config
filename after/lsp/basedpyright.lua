---@type vim.lsp.Config
return {
  cmd = { 'uvx', '--quiet', '--from', 'basedpyright', 'basedpyright-langserver', '--stdio' },
  settings = {
    basedpyright = {
      analysis = {
        diagnosticMode = 'workspace',
        inlayHints = {
          callArgumentNames = false
        }
      },
    },
  }
}
