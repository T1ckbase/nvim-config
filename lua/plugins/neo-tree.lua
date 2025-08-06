---@type LazySpec
return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    'nvim-tree/nvim-web-devicons', -- optional, but recommended
  },
  lazy = false,                    -- neo-tree will lazily load itself
  opts = {
    default_component_configs = {
      container = {
        enable_character_fade = false,
      },
      git_status = {
        symbols = {
          -- Change type
          added = 'A',
          modified = 'M',
          deleted = 'D',
          renamed = 'R',
          -- Status type
          untracked = 'U',
          ignored = 'I',
          unstaged = ' ',
          staged = 'S',
          conflict = 'C',
        },
      },
    },
    source_selector = {
      winbar = true,
      statusline = false
    },
    filesystem = {
      filtered_items = {
        hide_dotfiles = false,
        hide_gitignored = false,
      },
      hijack_netrw_behavior = 'open_current',
      use_libuv_file_watcher = vim.fn.has 'win32' ~= 1,
    }
  }
}
