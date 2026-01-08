local M = {}

---@type string[]
M.priority = {
  'biome',
  'denols',
  'tsgo',
  'vtsls',
  'eslint',
  'html',
  'cssls',
  'jsonls',
  'markdown',
  'astro',
  'svelte',
  'nushell',
  'stylua',
  'lua_ls',
  'ruff',
  'ty',
  'rust_analyzer',
  'zls',
}

---Format the current buffer using the prioritized LSP client.
---@param opts? table
function M.format(opts)
  opts = opts or {}
  local bufnr = opts.bufnr or vim.api.nvim_get_current_buf()

  local clients = vim.lsp.get_clients({ bufnr = bufnr })

  -- Filter clients that support formatting
  local formatters = {}
  for _, client in ipairs(clients) do
    if client:supports_method('textDocument/formatting') then
      table.insert(formatters, client)
    end
  end

  if #formatters == 0 then
    vim.notify('No active LSP clients support formatting', vim.log.levels.WARN)
    return
  end

  -- Sort formatters based on priority
  table.sort(formatters, function(a, b)
    local index_a = math.huge
    local index_b = math.huge

    for i, name in ipairs(M.priority) do
      if a.name == name then index_a = i end
      if b.name == name then index_b = i end
    end

    if index_a ~= index_b then
      return index_a < index_b
    end

    -- If neither is in priority list (or both same priority), sort by ID for stability
    return a.id < b.id
  end)

  -- Use the highest priority formatter
  ---@type vim.lsp.Client
  local chosen = formatters[1]

  -- If the highest priority one is NOT in our list, it means none of our preferred formatters are here.
  -- In that case, should we use ALL available? Or just the first one?
  -- But standard vim.lsp.buf.format uses all.
  -- Let's stick to "Use ONLY the best one" to avoid conflicts unconditionally.

  if #formatters > 1 then
    vim.notify('Formatting with: ' .. chosen.name, vim.log.levels.INFO)
  end

  vim.lsp.buf.format({
    bufnr = bufnr,
    id = chosen.id,
    async = opts.async,
    range = opts.range,
  })
end

return M
