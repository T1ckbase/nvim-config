---@type vim.lsp.Config
return {
  cmd = { 'pnpm', 'dlx', '--silent', 'typescript@latest', '--lsp', '--stdio' },
}
