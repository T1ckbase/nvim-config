require "nvchad.options"

-- add yours here!

-- vim.api.nvim_create_autocmd({ 'FileType' }, {
--   desc = 'Force commentstring to include spaces',
--   -- group = ...,
--   callback = function(event)
--     local cs = vim.bo[event.buf].commentstring
--     vim.bo[event.buf].commentstring = cs:gsub('(%S)%%s', '%1 %%s'):gsub('%%s(%S)', '%%s %1')
--   end,
-- })

local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
o.relativenumber = true

