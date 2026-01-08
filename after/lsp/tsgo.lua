---@type vim.lsp.Config
return {
  cmd = { 'deno', 'run', '--quiet', '--no-lock', '--allow-all', 'npm:@typescript/native-preview@latest', '--lsp', '--stdio' }, -- Using pnpm will error
  cmd_env = { NO_COLOR = true },
}
