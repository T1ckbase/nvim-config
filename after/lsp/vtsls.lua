---@type vim.lsp.Config
return {
  cmd = { 'pnpm', 'dlx', '--silent', '@vtsls/language-server@latest', '--stdio' },
}
