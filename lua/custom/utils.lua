M = {
  status = {},
  attached_lsp = {}
}

M.setup = function()
  M.create_autocommands()
end

---@param s string
M.escape = function(s)
  return (s:gsub('[%-%.%+%[%]%(%)%$%^%%%?%*]', '%%%1'))
end

M.ensure_kind_map = function()
  if H.kind_map ~= nil then return end

  -- Cache kind map so as to not recompute it each time (as it will be called
  -- in performance sensitive context). Assumes `tweak_lsp_kind()` is called
  -- right after `require('mini.icons').setup()`.
  M.kind_map = {}
  for k, v in pairs(vim.lsp.protocol.CompletionItemKind) do
    if type(k) == 'string' and type(v) == 'number' then H.kind_map[v] = k end
  end
end

--- @param bufnr integer
M.get_lsp_client_names = function(bufnr)
  bufnr = bufnr or 0
  local clients = vim.lsp.get_clients({ bufnr = bufnr })
  local names = {}
  for _, client in pairs(clients) do
    table.insert(names, client.name)
  end
  return names
end

---@param plugin_name string
M.get_plugin_path = function(plugin_name)
  for _, path in ipairs(vim.api.nvim_list_runtime_paths()) do
    if string.match(path, M.escape(plugin_name)) then
      return path
    end
  end
  return nil
end

M.status.macro_recording = function(args)
  local recording_register = vim.fn.reg_recording()
  if recording_register == '' then
    return ''
  end

  local use_icons = MiniStatusline.config.use_icons
  local icon = args.icon or (use_icons and ' ' or 'recording')
  return icon .. ' @' .. recording_register
end

M.status.lsp = function(args)
  local attached = M.attached_lsp[vim.api.nvim_get_current_buf()]
  if attached == nil then return '' end
  if MiniStatusline.is_truncated(args.trunc_width) then
    return MiniStatusline.section_lsp({ icon = args.icon })
  end

  local use_icons = MiniStatusline.config.use_icons
  local icon = args.icon or (use_icons and '󰰎 ' or 'LSP')
  return icon .. table.concat(attached, ', ')
end

M.create_autocommands = function()
  local gr = vim.api.nvim_create_augroup('custom-utils', {})

  local au = function(event, pattern, callback, desc)
    vim.api.nvim_create_autocmd(event, { group = gr, pattern = pattern, callback = callback, desc = desc })
  end

  -- Use `schedule_wrap()` because at `LspDetach` server is still present
  local track_lsp = vim.schedule_wrap(function(data)
    M.attached_lsp[data.buf] = vim.api.nvim_buf_is_valid(data.buf) and M.get_lsp_client_names(data.buf) or nil
  end)
  au({ 'LspAttach', 'LspDetach' }, '*', track_lsp, 'Track LSP clients')
end

return M
