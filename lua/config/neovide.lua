if vim.g.neovide then
  vim.o.guifont = 'JetBrainsMonoNL Nerd Font:h11'
  vim.opt.linespace = 0
  vim.g.neovide_scale_factor = 1.0
  vim.g.neovide_floating_shadow = false
  vim.g.neovide_title_background_color = 'black'
  vim.g.neovide_title_text_color = 'gray'
  vim.g.neovide_position_animation_length = 0.06
  vim.g.neovide_scroll_animation_length = 0.04
  vim.g.neovide_scroll_animation_far_lines = 5
  vim.g.neovide_refresh_rate = 165 -- This setting is only effective when not using vsync, for example by passing --no-vsync on the commandline.
  -- vim.g.neovide_refresh_rate_idle = 165
  vim.g.neovide_no_idle = true
  -- vim.g.neovide_profiler = true -- frametime graph
  vim.g.neovide_cursor_animation_length = 0.02
  vim.g.neovide_cursor_short_animation_length = 0
  vim.g.neovide_cursor_animate_in_insert_mode = false
  -- vim.g.neovide_cursor_vfx_mode = 'pixiedust'

  vim.keymap.set(
    '',
    '<F10>',
    function() vim.g.neovide_profiler = not vim.g.neovide_profiler end,
    { desc = 'Toggle Profiler' }
  )

  vim.keymap.set(
    '',
    '<F11>',
    function() vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen end,
    { desc = 'Toggle Fullscreen' }
  )

  vim.keymap.set('', '<C-F5>', function()
    local autocmd_group_id = vim.api.nvim_create_augroup('Restart', { clear = true })

    local id = vim.api.nvim_create_autocmd('VimLeavePre', {
      group = autocmd_group_id,
      pattern = '*',
      callback = function() vim.fn.system 'neovide' end,
    })

    vim.cmd 'qa'

    vim.api.nvim_del_autocmd(id)
  end, { desc = 'Restart Neovide' })
end
