---@type vim.lsp.Config
return {
  cmd = { 'pnpm', 'dlx', '--silent', 'yaml-language-server@1.24.0', '--stdio' },
}
