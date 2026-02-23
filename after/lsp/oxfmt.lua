---@type vim.lsp.Config
return {
  cmd = { 'pnpm', 'dlx', '--silent', 'oxfmt@latest', '--lsp' },
}
