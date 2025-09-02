---@type LazySpec
return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'master',
  main = 'nvim-treesitter.configs',
  dependencies = { { 'nvim-treesitter/nvim-treesitter-textobjects', lazy = false } },
  lazy = false,
  build = ':TSUpdate',
  init = function(plugin)
    -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
    -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
    -- no longer trigger the **nvim-treeitter** module to be loaded in time.
    -- Luckily, the only thins that those plugins need are the custom queries, which we make available
    -- during startup.
    -- CODE FROM LazyVim (thanks folke!) https://github.com/LazyVim/LazyVim/commit/1e1b68d633d4bd4faa912ba5f49ab6b8601dc0c9
    require('lazy.core.loader').add_to_rtp(plugin)
    pcall(require, 'nvim-treesitter.query_predicates')
  end,
  opts = {
    ensure_installed = {
      'astro',
      'c',
      'cpp',
      'css',
      'csv',
      'diff',
      'dockerfile',
      'editorconfig',
      'git_config',
      'git_rebase',
      'gitattributes',
      'gitcommit',
      'gitignore',
      'go',
      'html',
      'hlsl',
      'javascript',
      'jsdoc',
      'json',
      'jsonc',
      'lua',
      'markdown',
      'markdown_inline',
      'nu',
      'python',
      'query',
      'regex',
      'rust',
      'scss',
      'toml',
      'tsx',
      'typescript',
      'vim',
      'vimdoc',
      'yaml',
      'zig',
    },
    sync_install = false,
    auto_install = true,
    ignore_install = {},
    highlight = {
      enable = true,
      -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
      disable = function(lang, buf)
        local max_filesize = 1000 * 10 * 1024 -- 10 MB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
          return true
        end
      end,
      additional_vim_regex_highlighting = false,
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj
        keymaps = {
          ['ak'] = { query = '@block.outer', desc = 'around block' },
          ['ik'] = { query = '@block.inner', desc = 'inside block' },
          ['ac'] = { query = '@class.outer', desc = 'around class' },
          ['ic'] = { query = '@class.inner', desc = 'inside class' },
          ['a?'] = { query = '@conditional.outer', desc = 'around conditional' },
          ['i?'] = { query = '@conditional.inner', desc = 'inside conditional' },
          ['af'] = { query = '@function.outer', desc = 'around function ' },
          ['if'] = { query = '@function.inner', desc = 'inside function ' },
          ['ao'] = { query = '@loop.outer', desc = 'around loop' },
          ['io'] = { query = '@loop.inner', desc = 'inside loop' },
          ['aa'] = { query = '@parameter.outer', desc = 'around argument' },
          ['ia'] = { query = '@parameter.inner', desc = 'inside argument' },
        }
      },
      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = {
          [']k'] = { query = '@block.outer', desc = 'Next block start' },
          [']f'] = { query = '@function.outer', desc = 'Next function start' },
          [']a'] = { query = '@parameter.inner', desc = 'Next argument start' },
        },
        goto_next_end = {
          [']K'] = { query = '@block.outer', desc = 'Next block end' },
          [']F'] = { query = '@function.outer', desc = 'Next function end' },
          [']A'] = { query = '@parameter.inner', desc = 'Next argument end' },
        },
        goto_previous_start = {
          ['[k'] = { query = '@block.outer', desc = 'Previous block start' },
          ['[f'] = { query = '@function.outer', desc = 'Previous function start' },
          ['[a'] = { query = '@parameter.inner', desc = 'Previous argument start' },
        },
        goto_previous_end = {
          ['[K'] = { query = '@block.outer', desc = 'Previous block end' },
          ['[F'] = { query = '@function.outer', desc = 'Previous function end' },
          ['[A'] = { query = '@parameter.inner', desc = 'Previous argument end' },
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ['>K'] = { query = '@block.outer', desc = 'Swap next block' },
          ['>F'] = { query = '@function.outer', desc = 'Swap next function' },
          ['>A'] = { query = '@parameter.inner', desc = 'Swap next argument' },
        },
        swap_previous = {
          ['<K'] = { query = '@block.outer', desc = 'Swap previous block' },
          ['<F'] = { query = '@function.outer', desc = 'Swap previous function' },
          ['<A'] = { query = '@parameter.inner', desc = 'Swap previous argument' },
        },
      },
    },
    modules = {},
  }
}
