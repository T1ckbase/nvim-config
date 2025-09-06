---@type vim.lsp.Config
return {
  cmd = { 'deno', 'lsp' },
  cmd_env = { NO_COLOR = true },
  filetypes = { 'markdown', 'yaml' },
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    local file_dir = vim.fs.dirname(fname)
    on_dir(file_dir)
  end,
}
