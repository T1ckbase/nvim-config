if not vim.g.neovide then return end

vim.opt.guifont = 'JetBrainsMonoNL Nerd Font,Cascadia Mono,Symbols Nerd Font:h11:#e-subpixelantialias'
vim.opt.linespace = 0

vim.g.neovide_scale_factor = 1.0
vim.g.neovide_floating_shadow = false
vim.g.neovide_title_background_color = 'black'
vim.g.neovide_title_text_color = 'gray'
vim.g.neovide_floating_blur_amount_x = 0
vim.g.neovide_floating_blur_amount_y = 0
vim.g.neovide_position_animation_length = 0
vim.g.neovide_scroll_animation_length = 0
-- vim.g.neovide_scroll_animation_far_lines = 1
vim.g.neovide_refresh_rate = 165 -- This setting is only effective when not using vsync, for example by passing --no-vsync on the commandline.
-- vim.g.neovide_refresh_rate_idle = 165
vim.g.neovide_no_idle = true
-- vim.g.neovide_profiler = true -- frametime graph
vim.g.neovide_cursor_animation_length = 0.05
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
  local id = vim.api.nvim_create_autocmd('VimLeavePre', {
    group = vim.api.nvim_create_augroup('NeovideRestart', {}),
    pattern = '*',
    callback = function() vim.system({ 'neovide' }, { detach = true }) end,
  })

  vim.cmd('qa')

  vim.api.nvim_del_autocmd(id)
end, { desc = 'Restart Neovide' })

-- https://github.com/neovide/neovide/issues/1771
vim.api.nvim_create_autocmd('BufLeave', {
  group = vim.api.nvim_create_augroup('NeovideBufLeave', {}),
  callback = function()
    vim.g.neovide_scroll_animation_length = 0
    -- vim.g.neovide_cursor_animation_length = 0
  end,
})
vim.api.nvim_create_autocmd('BufEnter', {
  group = vim.api.nvim_create_augroup('NeovideBufEnter', {}),
  callback = function()
    vim.fn.timer_start(70, function()
      vim.g.neovide_scroll_animation_length = 0.04
      -- vim.g.neovide_cursor_animation_length = 0.02
    end)
  end,
})
