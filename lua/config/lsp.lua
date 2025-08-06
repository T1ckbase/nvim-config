vim.lsp.config('denols', {
  settings = {
    deno = {
      suggest = {
        imports = {
          hosts = {
            ['https://deno.land'] = false
          }
        },
      },
    },
  },
})

vim.lsp.config('basedpyright', {
  cmd = { 'uvx', '--quiet', '--from', 'basedpyright', 'basedpyright-langserver', '--stdio' },
})

vim.lsp.config('ruff', {
  cmd = { 'uvx', '--quiet', 'ruff', 'server' },
})

vim.lsp.config('pyright', {
  cmd = { 'uvx', '--quiet', '--from', 'pyright', 'pyright-langserver', '--stdio' },
})

vim.lsp.config('ty', {
  cmd = { 'uvx', '--quiet', 'ty', 'server' },
})

vim.lsp.enable({
  'lua_ls',
  'denols',
  'basedpyright',
  'ruff',
  -- 'pyright',
  -- 'ty',
})

vim.diagnostic.config({
  virtual_text = {
    severity = { min = vim.diagnostic.severity.ERROR }
  },
  underline = true,
  update_in_insert = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = 'minimal',
    border = 'single',
    source = true,
    header = '',
    prefix = '',
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN] = '󰀪 ',
      [vim.diagnostic.severity.INFO] = '󰋽 ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
    },
  },
})
