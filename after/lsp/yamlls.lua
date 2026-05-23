---@type vim.lsp.Config
return {
  cmd = { 'pnpm', 'dlx', '--silent', 'yaml-language-server@1.23.0', '--stdio' },
}
