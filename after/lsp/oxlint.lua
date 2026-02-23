---@type vim.lsp.Config
return {
  cmd = { 'pnpm', 'dlx', '--silent', 'oxlint@latest', '--lsp' },
}
