---@type vim.lsp.Config
return {
  cmd = { 'pnpm', 'dlx', '--silent', '--package=@t1ckbase/vscode-langservers-extracted@latest', 'vscode-eslint-language-server', '--stdio' },
}
