if true then return {} end

---@type LazySpec
return {
  -- 'nyoom-engineering/oxocarbon.nvim',
  'Mofiqul/vscode.nvim',
  lazy = false,    -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other plugins
}

-- ---@type LazySpec
-- return { 'rebelot/kanagawa.nvim' }

-- ---@type LazySpec
-- return { 'ellisonleao/gruvbox.nvim', priority = 1000, config = true }
