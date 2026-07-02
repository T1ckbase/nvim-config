---@type vim.lsp.Config
return {
  cmd = { 'uv', 'run', 'ruff', 'server' },
  root_markers = { 'ruff.toml', '.ruff.toml' },
  workspace_required = true,
}
