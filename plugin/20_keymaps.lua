vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

vim.keymap.set({ 'n', 'i' }, '<M-J>', '<Cmd>copy .<cr>', { desc = 'Copy Line Down' })
vim.keymap.set({ 'n', 'i' }, '<M-K>', '<Cmd>copy .-1<cr>', { desc = 'Copy Line Up' })
vim.keymap.set('x', '<M-J>', ":<C-u>'<,'>copy '<-1<cr>gv=gv", { desc = 'Copy Selection Down' })
vim.keymap.set('x', '<M-K>', ":<C-u>'<,'>copy '><cr>gv=gv", { desc = 'Copy Selection Up' })

vim.keymap.set('n', '<C-s>', '<Cmd>w<CR>', { desc = 'Force write', silent = true })

vim.keymap.set({ 'i', 'c' }, '<C-v>', '<C-r>+', { desc = 'Paste' })

vim.keymap.set('n', '<C-Left>', '"<Cmd>vertical resize -" . v:count1 . "<CR>"', { expr = true, replace_keycodes = false, desc = 'Decrease window width' })
vim.keymap.set('n', '<C-Down>', '"<Cmd>resize -" . v:count1 . "<CR>"', { expr = true, replace_keycodes = false, desc = 'Decrease window height' })
vim.keymap.set('n', '<C-Up>', '"<Cmd>resize +" . v:count1 . "<CR>"', { expr = true, replace_keycodes = false, desc = 'Increase window height' })
vim.keymap.set('n', '<C-Right>', '"<Cmd>vertical resize +" . v:count1 . "<CR>"', { expr = true, replace_keycodes = false, desc = 'Increase window width' })

-- lsp
vim.keymap.set('n', 'K', function() vim.lsp.buf.hover({ max_width = 100, max_height = 20, border = 'solid' }) end, { desc = 'vim.lsp.buf.hover()' })
vim.keymap.set('n', '<leader>ld', function() vim.diagnostic.open_float(nil, { focusable = true, border = 'solid' }) end, { desc = 'Hover diagnostic' })
vim.keymap.set({ 'n', 'x' }, 'g.', vim.lsp.buf.code_action, { desc = 'Code Action' })
vim.keymap.set('n', 'gd', function() MiniPick.registry.lsp_jump({ scope = 'definition' }) end, { desc = 'Goto Definition' })
vim.keymap.set('n', 'gD', function() MiniPick.registry.lsp_jump({ scope = 'declaration' }) end, { desc = 'Goto Declaration' })
vim.keymap.set('n', 'gO', function() MiniExtra.pickers.lsp({ scope = 'document_symbol' }) end, { desc = 'Document symbols' })
vim.keymap.set('n', 'gri', function() MiniExtra.pickers.lsp({ scope = 'implementation' }) end, { desc = 'Goto Implementation' })
vim.keymap.set('n', 'grr', function() MiniExtra.pickers.lsp({ scope = 'references' }) end, { desc = 'Goto References' })
vim.keymap.set('n', 'grt', function() MiniPick.registry.lsp_jump({ scope = 'type_definition' }) end, { desc = 'Goto Type Definition' })
vim.keymap.set('n', 'gw', function() MiniExtra.pickers.lsp({ scope = 'workspace_symbol_live' }) end, { desc = 'Workspace symbols' })
vim.keymap.set('n', '<leader>lf', function() require('custom.format').format() end, { desc = 'Format buffer' })

vim.keymap.set('n', '<C-w>gd', function()
  vim.cmd.vsplit()
  MiniPick.registry.lsp_jump({ scope = 'definition' })
end, { desc = 'Go to definition in a new vertical split' })

vim.keymap.set('n', '<C-w>gD', function()
  vim.cmd.vsplit()
  MiniPick.registry.lsp_jump({ scope = 'declaration' })
end, { desc = 'Go to declaration in a new vertical split' })

vim.keymap.set('n', '<C-w>gri', function()
  vim.cmd.vsplit()
  MiniExtra.pickers.lsp({ scope = 'implementation' })
end, { desc = 'Go to implementation in a new vertical split' })

vim.keymap.set('n', '<C-w>grr', function()
  vim.cmd.vsplit()
  MiniExtra.pickers.lsp({ scope = 'references' })
end, { desc = 'Go to references in a new vertical split' })

vim.keymap.set('n', '<C-w>grt', function()
  vim.cmd.vsplit()
  MiniPick.registry.lsp_jump({ scope = 'type_definition' })
end, { desc = 'Go to type_definition in a new vertical split' })

vim.keymap.set('n', '<leader>e', function() if not MiniFiles.close() then MiniFiles.open() end end, { desc = 'Toggle Explorer' })

-- Disable `s` shortcut (use `cl` instead) for safer usage of 'mini.surround'
vim.keymap.set({ 'n', 'x' }, 's', '<Nop>')

vim.keymap.set('n', "<leader>f'", function() MiniExtra.pickers.marks() end, { desc = 'Find marks' })
vim.keymap.set('n', '<leader>f/', function() MiniExtra.pickers.history({ scope = '/' }) end, { desc = 'Find search history' })
vim.keymap.set('n', '<leader>f:', function() MiniExtra.pickers.history({ scope = ':' }) end, { desc = 'Find command history' })
vim.keymap.set('n', '<leader>fb', function() MiniPick.builtin.buffers() end, { desc = 'Find buffers' })
vim.keymap.set('n', '<leader>fe', function() MiniExtra.pickers.explorer() end, { desc = 'File explorer' })
vim.keymap.set('n', '<leader>ff', function() MiniPick.registry.files({ hidden = true }) end, { desc = 'Find files' })
vim.keymap.set('n', '<leader>fF', function() MiniPick.registry.files({ hidden = true, ignored = true }) end, { desc = 'Find all files' })
vim.keymap.set('n', '<leader>fh', function() MiniPick.builtin.help() end, { desc = 'Find help' })
vim.keymap.set('n', '<leader>fH', function() MiniExtra.pickers.hl_groups() end, { desc = 'Find highlights' })
vim.keymap.set('n', '<leader>fk', function() MiniExtra.pickers.keymaps() end, { desc = 'Find keymaps' })
vim.keymap.set('n', '<leader>fr', function() MiniExtra.pickers.registers() end, { desc = 'Find registers' })
vim.keymap.set('n', '<leader>ft', function() MiniExtra.pickers.colorschemes() end, { desc = 'Find themes' })
vim.keymap.set('n', '<leader>fw', function() MiniPick.registry.grep_live({ hidden = true }) end, { desc = 'Find words' })
vim.keymap.set('n', '<leader>fW', function() MiniPick.registry.grep_live({ hidden = true, ignored = true }) end, { desc = 'Find all words' })

vim.keymap.set('n', '<leader>lD', function() MiniExtra.pickers.diagnostic() end, { desc = 'Search diagnostic' })

vim.keymap.set('n', '<leader>nh', function() MiniNotify.show_history() end, { desc = 'Notify history' })
