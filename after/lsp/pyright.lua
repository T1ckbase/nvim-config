---@type vim.lsp.Config
return {
  cmd = { 'uvx', '--quiet', '--from', 'pyright', 'pyright-langserver', '--stdio' },
}
