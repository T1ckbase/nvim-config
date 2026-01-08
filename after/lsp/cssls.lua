---@type vim.lsp.Config
return {
  cmd = { 'pnpm', 'run', '--silent', '--package=@t1ckbase/vscode-langservers-extracted@latest', 'vscode-css-language-server', '--stdio' },
}
