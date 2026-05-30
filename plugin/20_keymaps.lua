vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

vim.keymap.set({ 'n', 'i' }, '<M-J>', '<Cmd>copy .<CR>', { desc = 'Copy Line Down' })
vim.keymap.set({ 'n', 'i' }, '<M-K>', '<Cmd>copy .-1<CR>', { desc = 'Copy Line Up' })
vim.keymap.set('x', '<M-J>', ":<C-u>'<,'>copy '<-1<CR>gv=gv", { desc = 'Copy Selection Down' })
vim.keymap.set('x', '<M-K>', ":<C-u>'<,'>copy '><CR>gv=gv", { desc = 'Copy Selection Up' })

vim.keymap.set('n', '<C-s>', '<Cmd>w<CR>', { desc = 'Write', silent = true })

vim.keymap.set({ 'i', 'c' }, '<C-v>', '<C-r>+', { desc = 'Paste' })

vim.keymap.set('n', '<C-Left>', '"<Cmd>vertical resize -" . v:count1 . "<CR>"', { expr = true, replace_keycodes = false, desc = 'Decrease window width' })
vim.keymap.set('n', '<C-Down>', '"<Cmd>resize -" . v:count1 . "<CR>"', { expr = true, replace_keycodes = false, desc = 'Decrease window height' })
vim.keymap.set('n', '<C-Up>', '"<Cmd>resize +" . v:count1 . "<CR>"', { expr = true, replace_keycodes = false, desc = 'Increase window height' })
vim.keymap.set('n', '<C-Right>', '"<Cmd>vertical resize +" . v:count1 . "<CR>"', { expr = true, replace_keycodes = false, desc = 'Increase window width' })

-- lsp
vim.keymap.set('i', '<M-l>', function() vim.lsp.inline_completion.get() end, { desc = 'vim.lsp.inline_completion.get()' })
vim.keymap.set('n', 'K', function() vim.lsp.buf.hover({ max_width = 100, max_height = 20, border = 'solid' }) end, { desc = 'vim.lsp.buf.hover()' })
vim.keymap.set('n', '<C-w>d', function() vim.diagnostic.open_float(nil, { focusable = true, border = 'solid' }) end, { desc = 'Show diagnostics under the cursor' })
vim.keymap.set('n', '<leader>ld', '<C-w>d', { remap = true, desc = 'Show diagnostics under the cursor' })
vim.keymap.set({ 'n', 'x' }, 'g.', vim.lsp.buf.code_action, { desc = 'Code Action' })
vim.keymap.set('n', 'gd', function() Snacks.picker.lsp_definitions() end, { desc = 'Goto Definition' })
vim.keymap.set('n', 'gD', function() Snacks.picker.lsp_declarations() end, { desc = 'Goto Declaration' })
vim.keymap.set('n', 'gO', function() Snacks.picker.lsp_symbols() end, { desc = 'Document symbols' })
vim.keymap.set('n', 'gri', function() Snacks.picker.lsp_implementations() end, { desc = 'Goto Implementation' })
vim.keymap.set('n', 'grr', function() Snacks.picker.lsp_references() end, { desc = 'Goto References' })
vim.keymap.set('n', 'grt', function() Snacks.picker.lsp_type_definitions() end, { desc = 'Goto Type Definition' })
vim.keymap.set('n', 'gai', function() Snacks.picker.lsp_incoming_calls() end, { desc = 'Incoming Calls' })
vim.keymap.set('n', 'gao', function() Snacks.picker.lsp_outgoing_calls() end, { desc = 'Outgoing Calls' })
vim.keymap.set('n', 'gw', function() Snacks.picker.lsp_workspace_symbols() end, { desc = 'Workspace Symbols' })

local format_priority = {
  biome = 1,
  oxfmt = 2,
  oxlint = 3,
  denols = 4,
  tsgo = 5,
  vtsls = 6,
  eslint = 7,
  html = 8,
  cssls = 9,
  jsonls = 10,
  markdown = 11,
  clangd = 12,
  astro = 13,
  svelte = 14,
  nushell = 15,
  stylua = 16,
  lua_ls = 17,
  ruff = 18,
  ty = 19,
  rust_analyzer = 20,
  zls = 21,
  tombi = 22,
}

vim.keymap.set('n', '<leader>lf', function()
  local clients = vim.lsp.get_clients({
    bufnr = vim.api.nvim_get_current_buf(),
    method = 'textDocument/formatting',
  })

  table.sort(clients, function(a, b)
    local index_a = format_priority[a.name] or math.huge
    local index_b = format_priority[b.name] or math.huge

    if index_a ~= index_b then return index_a < index_b end

    return a.id < b.id
  end)

  local chosen = clients[1]
  vim.lsp.buf.format({
    id = chosen and chosen.id,
  })
end, { desc = 'Format Buffer' })

vim.keymap.set('n', '<leader>e', function()
  if not MiniFiles.close() then MiniFiles.open() end
end, { desc = 'Toggle Explorer' })

-- Disable `s` shortcut (use `cl` instead) for safer usage of 'mini.surround'
vim.keymap.set({ 'n', 'x' }, 's', '<Nop>')

vim.keymap.set('n', "<leader>f'", function() Snacks.picker.marks() end, { desc = 'Marks' })
vim.keymap.set('n', '<leader>f/', function() Snacks.picker.search_history() end, { desc = 'Search History' })
vim.keymap.set('n', '<leader>f:', function() Snacks.picker.command_history() end, { desc = 'Command History' })
vim.keymap.set('n', '<leader>fb', function() Snacks.picker.buffers() end, { desc = 'Buffers' })
vim.keymap.set('n', '<leader>fd', function() Snacks.picker.diagnostics_buffer() end, { desc = 'Buffer Diagnostics' })
vim.keymap.set('n', '<leader>fD', function() Snacks.picker.diagnostics() end, { desc = 'Diagnostics' })
-- vim.keymap.set('n', '<leader>fe', function() Snacks.explorer() end, { desc = 'File Explorer' })
vim.keymap.set('n', '<leader>ff', function() Snacks.picker.files({ hidden = true }) end, { desc = 'Find files' })
vim.keymap.set('n', '<leader>fF', function() Snacks.picker.files({ hidden = true, ignored = true }) end, { desc = 'Find All Files' })
vim.keymap.set('n', '<leader>fh', function() Snacks.picker.help() end, { desc = 'Help Pages' })
vim.keymap.set('n', '<leader>fH', function() Snacks.picker.highlights() end, { desc = 'Highlights' })
vim.keymap.set('n', '<leader>fk', function() Snacks.picker.keymaps() end, { desc = 'Keymaps' })
vim.keymap.set('n', '<leader>fr', function() Snacks.picker.registers() end, { desc = 'Registers' })
vim.keymap.set('n', '<leader>ft', function() Snacks.picker.colorschemes() end, { desc = 'Colorschemes' })
vim.keymap.set('n', '<leader>fw', function() Snacks.picker.grep({ hidden = true }) end, { desc = 'Grep' })
vim.keymap.set('n', '<leader>fW', function() Snacks.picker.grep({ hidden = true, ignored = true }) end, { desc = 'Grep All' })
vim.keymap.set('n', '<leader><space>', function() Snacks.picker.resume() end, { desc = 'Resume picker' })

vim.keymap.set('n', '<leader>nh', function() MiniNotify.show_history() end, { desc = 'Notify History' })
