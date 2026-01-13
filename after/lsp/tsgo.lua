---@type vim.lsp.Config
return {
  cmd = { 'pnpm', 'dlx', '--silent', '@typescript/native-preview@latest', '--lsp', '--stdio' },
  cmd_env = { NO_COLOR = true },
}
