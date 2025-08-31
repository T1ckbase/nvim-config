local M = {}

---@return string
function M.mode_component()
  -- This is the function you found on Reddit.
  -- Note that: \19 = ^S and \22 = ^V.
  local mode_to_str = {
    ['n'] = 'NORMAL',
    ['no'] = 'OP-PENDING',
    ['nov'] = 'OP-PENDING',
    ['noV'] = 'OP-PENDING',
    ['no\22'] = 'OP-PENDING',
    ['niI'] = 'NORMAL',
    ['niR'] = 'NORMAL',
    ['niV'] = 'NORMAL',
    ['nt'] = 'NORMAL',
    ['ntT'] = 'NORMAL',
    ['v'] = 'VISUAL',
    ['vs'] = 'VISUAL',
    ['V'] = 'VISUAL LINE',
    ['Vs'] = 'VISUAL LINE',
    ['\22'] = 'VISUAL BLOCK',
    ['\22s'] = 'VISUAL BLOCK',
    ['s'] = 'SELECT',
    ['S'] = 'SELECT LINE',
    ['\19'] = 'SELECT BLOCK',
    ['i'] = 'INSERT',
    ['ic'] = 'INSERT',
    ['ix'] = 'INSERT',
    ['R'] = 'REPLACE',
    ['Rc'] = 'REPLACE',
    ['Rx'] = 'REPLACE',
    ['Rv'] = 'VIRT REPLACE',
    ['Rvc'] = 'VIRT REPLACE',
    ['Rvx'] = 'VIRT REPLACE',
    ['c'] = 'COMMAND',
    ['cv'] = 'VIM EX',
    ['ce'] = 'EX',
    ['r'] = 'PROMPT',
    ['rm'] = 'MORE',
    ['r?'] = 'CONFIRM',
    ['!'] = 'SHELL',
    ['t'] = 'TERMINAL',
  }

  -- Get the respective string to display.
  local current_mode = vim.api.nvim_get_mode().mode
  local mode_string = ' ' .. (mode_to_str[current_mode] or current_mode):upper() .. ' '

  -- -- Set the highlight group name based on the mode.
  -- local hl_name = 'Normal' -- Default
  -- if current_mode:find 'n' then
  --   hl_name = 'Normal'
  -- elseif current_mode:find '[o]' then
  --   hl_name = 'Pending'
  -- elseif current_mode:find '[vV\22]' then
  --   hl_name = 'Visual'
  -- elseif current_mode:find '[iR]' then
  --   hl_name = 'Insert'
  -- elseif current_mode:find '[c!t]' then
  --   hl_name = 'Command'
  -- end

  -- -- Construct the component with highlight groups.
  -- return table.concat {
  --   string.format('%%#StatuslineModeSeparator%s#', hl_name), -- Left separator
  --   string.format('%%#StatuslineMode%s#%s', hl_name, mode_string), -- Mode text
  --   string.format('%%#StatuslineModeSeparator%s#', hl_name), -- Right separator
  -- }

  return mode_string
end

return M
