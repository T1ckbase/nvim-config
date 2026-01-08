---@type vim.lsp.Config
return {
  cmd = { 'pnpm', 'dlx', '--silent', '@olrtg/emmet-language-server@latest', '--stdio' },
}
