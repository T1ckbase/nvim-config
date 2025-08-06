vim.keymap.set('i', '<C-/>', '<ESC>mbgcc`ba', { desc = 'Toggle comment', remap = true })
vim.keymap.set('n', '<C-/>', 'mbgcc`b', { desc = 'Toggle comment', remap = true })
vim.keymap.set('v', '<C-/>', 'mbgc`b', { desc = 'Toggle comment', remap = true })
vim.keymap.set('n', '<A-j>', "<cmd>execute 'move .+' . v:count1<cr>==", { desc = 'Move Down' })
vim.keymap.set('n', '<A-k>', "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = 'Move Up' })
vim.keymap.set('i', '<A-j>', '<esc><cmd>m .+1<cr>==gi', { desc = 'Move Down' })
vim.keymap.set('i', '<A-k>', '<esc><cmd>m .-2<cr>==gi', { desc = 'Move Up' })
vim.keymap.set('v', '<A-j>', ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = 'Move Down' })
vim.keymap.set('v', '<A-k>', ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = 'Move Up' })
vim.keymap.set({ 'n', 'i' }, '<A-J>', '<Cmd>copy .<cr>', { desc = 'Copy Line Down' })
vim.keymap.set({ 'n', 'i' }, '<A-K>', '<Cmd>copy .-1<cr>', { desc = 'Copy Line Up' })
vim.keymap.set('v', '<A-J>', ":<C-u>'<,'>copy '<-1<cr>gv=gv", { desc = 'Copy Selection Down' })
vim.keymap.set('v', '<A-K>', ":<C-u>'<,'>copy '><cr>gv=gv", { desc = 'Copy Selection Up' })

vim.keymap.set({ 'n', 'x' }, '<C-s>', '<Cmd>silent! update! | redraw<CR>', { remap = true, desc = 'Force write' })
vim.keymap.set({ 'i', 'n', 's' }, '<Esc>', '<Cmd>noh<CR>', { remap = true, desc = 'Clear search highlight' })

vim.keymap.set('n', '<leader>e', '<Cmd>Neotree toggle<CR>', { remap = true, desc = 'Toggle Explorer' })

vim.keymap.set('n', '<leader>/', 'gcc', { remap = true, silent = true, desc = 'Toggle comment' })
vim.keymap.set('v', '<leader>/', 'gc', { remap = true, silent = true, desc = 'Toggle comment line' })

vim.keymap.set('n', '[b', '<cmd>bprevious<cr>', { desc = 'Prev Buffer' })
vim.keymap.set('n', ']b', '<cmd>bnext<cr>', { desc = 'Next Buffer' })

vim.keymap.set('n', '<C-K>', vim.diagnostic.open_float, { desc = 'Hover diagnostic' })
vim.keymap.set({ 'n', 'x' }, 'g.', vim.lsp.buf.code_action, { desc = 'Code Action' })
