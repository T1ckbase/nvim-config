---@type vim.lsp.Config
return {
  cmd = { 'pnpm', 'dlx', '--silent', '--package=@t1ckbase/vscode-langservers-extracted@latest', 'vscode-markdown-language-server', '--stdio' },
  -- cmd = { 'deno', 'run', '--quiet', '--no-lock', '--allow-all', 'npm:vscode-markdown-languageserver/dist/node/workerMain.js', '--stdio' },
  -- cmd_env = { NO_COLOR = true },
  filetypes = { 'markdown' },
  root_markers = { '.git' },
}
