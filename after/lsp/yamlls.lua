---@type vim.lsp.Config
return {
  cmd = { 'pnpm', 'dlx', '--silent', 'yaml-language-server@latest', '--stdio' },
}
