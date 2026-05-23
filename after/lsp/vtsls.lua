---@type vim.lsp.Config
return {
  cmd = { 'pnpm', 'dlx', '--silent', '@vtsls/language-server@0.3.0', '--stdio' },
}
