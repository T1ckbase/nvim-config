vim.keymap.set('i', '<C-/>', '<ESC>mbgcc`ba', { remap = true, desc = 'Toggle comment line' })
vim.keymap.set('n', '<C-/>', 'mbgcc`b', { remap = true, desc = 'Toggle comment line' })
vim.keymap.set('x', '<C-/>', 'mbgc`b', { remap = true, desc = 'Toggle comment line' })
vim.keymap.set('n', '<leader>/', 'gcc', { remap = true, silent = true, desc = 'Toggle comment' })
vim.keymap.set('x', '<leader>/', 'gc', { remap = true, silent = true, desc = 'Toggle comment line' })

vim.keymap.set({ 'n', 'i' }, '<M-J>', '<Cmd>copy .<cr>', { desc = 'Copy Line Down' })
vim.keymap.set({ 'n', 'i' }, '<M-K>', '<Cmd>copy .-1<cr>', { desc = 'Copy Line Up' })
vim.keymap.set('x', '<M-J>', ":<C-u>'<,'>copy '<-1<cr>gv=gv", { desc = 'Copy Selection Down' })
vim.keymap.set('x', '<M-K>', ":<C-u>'<,'>copy '><cr>gv=gv", { desc = 'Copy Selection Up' })

vim.keymap.set('n', '*', function()
  local count = vim.v.count
  vim.fn.setreg('/', '\\<' .. vim.fn.expand('<cword>') .. '\\>')
  if count > 0 then
    vim.cmd('normal! ' .. count .. 'n')
  else
    vim.cmd.set('hlsearch')
  end
end, { desc = 'Search whole word under cursor, jump only with count' })
vim.keymap.set('n', '#', function()
  local count = vim.v.count
  vim.fn.setreg('/', '\\<' .. vim.fn.expand('<cword>') .. '\\>')
  if count > 0 then
    vim.cmd('normal! ' .. count .. 'N')
  else
    vim.cmd.set('hlsearch')
  end
end, { desc = 'Search whole word under cursor backward, jump only with count' })
vim.keymap.set('n', 'g*', function()
  local count = vim.v.count
  vim.fn.setreg('/', vim.fn.expand('<cword>'))
  if count > 0 then
    vim.cmd('normal! ' .. count .. 'n')
  else
    vim.cmd.set('hlsearch')
  end
end, { desc = 'Search partial word under cursor, jump only with count' })
vim.keymap.set('n', 'g#', function()
  local count = vim.v.count
  vim.fn.setreg('/', vim.fn.expand('<cword>'))
  if count > 0 then
    vim.cmd('normal! ' .. count .. 'N')
  else
    vim.cmd.set('hlsearch')
  end
end, { desc = 'Search partial word under cursor backward, jump only with count' })

local function _visual_search(forward)
  assert(forward == 0 or forward == 1)
  local pos = vim.fn.getpos('.')
  local vpos = vim.fn.getpos('v')
  local mode = vim.fn.mode()
  local chunks = vim.fn.getregion(pos, vpos, { type = mode })
  local esc_chunks = vim
      .iter(chunks)
      :map(function(v)
        return vim.fn.escape(v, [[\]])
      end)
      :totable()
  local esc_pat = table.concat(esc_chunks, [[\n]])
  if #esc_pat == 0 then
    vim.api.nvim_echo({ { 'E348: No string under cursor' } }, true, { err = true })
    return '<Esc>'
  end
  local search = [[\V]] .. esc_pat

  vim.fn.setreg('/', search)
  vim.fn.histadd('/', search)
  vim.v.searchforward = forward
  vim.cmd.set('hlsearch')

  local count = vim.v.count
  if count > 0 then
    -- The count has to be adjusted when searching backwards and the cursor
    -- isn't positioned at the beginning of the selection
    if forward == 0 then
      local _, line, col, _ = unpack(pos)
      local _, vline, vcol, _ = unpack(vpos)
      if
          line > vline
          or mode == 'v' and line == vline and col > vcol
          or mode == 'V' and col ~= 1
          or mode == '\22' and col > vcol
      then
        count = count + 1
      end
    end
    return '<Esc>' .. count .. 'n'
  else
    return '<Esc>'
  end
end

vim.keymap.set('x', '*', function()
  return _visual_search(1)
end, { desc = 'Search selected text forward, jump only with count', expr = true })

vim.keymap.set('x', '#', function()
  return _visual_search(0)
end, { desc = 'Search selected text backward, jump only with count', expr = true })

vim.keymap.set('n', '<C-s>', '<Cmd>w<CR>', { desc = 'Force write', silent = true })

vim.keymap.set({ 'i', 'c' }, '<C-v>', '<C-r>+', { desc = 'Paste' })

vim.keymap.set('n', '<Esc>', '<Cmd>nohlsearch<CR>', { desc = 'Clear search highlight' })

vim.keymap.set('n', '[b', '<Cmd>bprevious<CR>', { desc = 'Prev Buffer' })
vim.keymap.set('n', ']b', '<Cmd>bnext<CR>', { desc = 'Next Buffer' })
vim.keymap.set('n', '<leader>n', '<Cmd>enew<CR>', { desc = 'New file' })

vim.keymap.set('n', '<C-Left>', '"<Cmd>vertical resize -" . v:count1 . "<CR>"', { expr = true, replace_keycodes = false, desc = 'Decrease window width' })
vim.keymap.set('n', '<C-Down>', '"<Cmd>resize -"          . v:count1 . "<CR>"', { expr = true, replace_keycodes = false, desc = 'Decrease window height' })
vim.keymap.set('n', '<C-Up>', '"<Cmd>resize +"          . v:count1 . "<CR>"', { expr = true, replace_keycodes = false, desc = 'Increase window height' })
vim.keymap.set('n', '<C-Right>', '"<Cmd>vertical resize +" . v:count1 . "<CR>"', { expr = true, replace_keycodes = false, desc = 'Increase window width' })

vim.keymap.set('n', 'K', function() vim.lsp.buf.hover({ max_width = 100, max_height = 20 }) end, { desc = 'vim.lsp.buf.hover()' })
vim.keymap.set('n', '<leader>ld', function() vim.diagnostic.open_float(nil, { focusable = true }) end, { desc = 'Hover diagnostic' })
vim.keymap.set({ 'n', 'x' }, 'g.', vim.lsp.buf.code_action, { desc = 'Code Action' })
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'Go to declaration' })
vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, { desc = 'Go to type definition' })
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format, { desc = 'Format buffer' })

vim.keymap.set('n', '<C-w>gd', function()
  vim.cmd.vsplit()
  vim.lsp.buf.definition()
end, { desc = 'Go to definition in a new vertical split' })
vim.keymap.set('n', '<C-w>gD', function()
  vim.cmd.vsplit()
  vim.lsp.buf.declaration()
end, { desc = 'Go to declaration in a new vertical split' })
vim.keymap.set('n', '<C-w>gy', function()
  vim.cmd.vsplit()
  vim.lsp.buf.type_definition()
end, { desc = 'Go to type_definition in a new vertical split' })


local ts_repeat_move = require('nvim-treesitter.textobjects.repeatable_move')
vim.keymap.set({ 'n', 'x', 'o' }, ';', ts_repeat_move.repeat_last_move)
vim.keymap.set({ 'n', 'x', 'o' }, ',', ts_repeat_move.repeat_last_move_opposite)
vim.keymap.set({ 'n', 'x', 'o' }, 'f', ts_repeat_move.builtin_f_expr, { expr = true })
vim.keymap.set({ 'n', 'x', 'o' }, 'F', ts_repeat_move.builtin_F_expr, { expr = true })
vim.keymap.set({ 'n', 'x', 'o' }, 't', ts_repeat_move.builtin_t_expr, { expr = true })
vim.keymap.set({ 'n', 'x', 'o' }, 'T', ts_repeat_move.builtin_T_expr, { expr = true })

-- Disable `s` shortcut (use `cl` instead) for safer usage of 'mini.surround'
vim.keymap.set({ 'n', 'x' }, 's', '<Nop>')

vim.keymap.set('n', '<leader>e', function() if not MiniFiles.close() then MiniFiles.open() end end, { desc = 'Toggle Explorer' })

vim.keymap.set('n', '<leader>c', function() MiniBufremove.wipeout() end, { desc = 'Close buffer' })
vim.keymap.set('n', '<leader>C', function() MiniBufremove.wipeout(0, true) end, { desc = 'Close buffer!' })

vim.keymap.set('n', "<leader>f'", function() MiniExtra.pickers.marks() end, { desc = 'Find marks' })
vim.keymap.set('n', '<leader>fb', function() MiniPick.builtin.buffers() end, { desc = 'Find buffers' })
vim.keymap.set('n', '<leader>fe', function() MiniExtra.pickers.explorer() end, { desc = 'File explorer' })
vim.keymap.set('n', '<leader>ff', function() MiniPick.builtin.files() end, { desc = 'Find files' })
vim.keymap.set('n', '<leader>fg', function() MiniExtra.pickers.hl_groups() end, { desc = 'Find highlight groups' })
vim.keymap.set('n', '<leader>fh', function() MiniPick.builtin.help() end, { desc = 'Find help' })
vim.keymap.set('n', '<leader>fk', function() MiniExtra.pickers.keymaps() end, { desc = 'Find keymaps' })
vim.keymap.set('n', '<leader>fr', function() MiniExtra.pickers.registers() end, { desc = 'Find registers' })
vim.keymap.set('n', '<leader>ft', function() MiniExtra.pickers.colorschemes() end, { desc = 'Find themes' })
vim.keymap.set('n', '<leader>fw', function() MiniPick.builtin.grep_live() end, { desc = 'Find words' })
vim.keymap.set('n', '<leader>lD', function() MiniExtra.pickers.diagnostic() end, { desc = 'Search diagnostic' })
vim.keymap.set('n', '<leader>lG', function() MiniExtra.pickers.lsp({ scope = 'workspace_symbol' }) end, { desc = 'Search workspace symbols' })
vim.keymap.set('n', '<leader>ls', function() MiniExtra.pickers.lsp({ scope = 'document_symbol' }) end, { desc = 'Search document symbols' })

vim.keymap.set('n', '<leader>h',
  function()
    if vim.bo.filetype == 'ministarter' then
      MiniStarter.close()
    else
      MiniFiles.close()
      MiniStarter.open()
    end
  end,
  { desc = 'Home screen' }
)

vim.keymap.set({ 'n', 'x', 'o' }, '<leader>j',
  function() MiniJump2d.start(MiniJump2d.builtin_opts.single_character) end,
  { desc = 'MiniJump2d (single_character)' }
)

vim.keymap.set('n', '<leader>nh', function() MiniNotify.show_history() end, { desc = 'Notify history' })
