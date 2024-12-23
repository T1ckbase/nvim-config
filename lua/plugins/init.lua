return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "vim", "lua", "vimdoc", "html", "css", 'javascript', 'typescript', 'tsx', 'json', 'jsonc' },
    },
  },

  {
    'gelguy/wilder.nvim',
    event = "CmdlineEnter",
    config = function()
      local wilder = require 'wilder'
      wilder.setup({ modes = { ':', '/', '?' } })
      wilder.set_option('renderer', wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
        highlighter = wilder.basic_highlighter(),
        left = { " ", wilder.popupmenu_devicons() },
        right = { " ", wilder.popupmenu_scrollbar { thumb_char = " " } },
        highlights = {
          default = "WilderMenu",
          border = 'Whitespace',
          accent = wilder.make_hl("WilderAccent", "Pmenu", {
            { a = 1 },
            { a = 1 },
            { foreground = "#c586c0" },
          }),
        },
        border = 'rounded',
      })))
    end,
  },

  {
    "folke/ts-comments.nvim",
    opts = {},
    event = "VeryLazy",
    enabled = vim.fn.has("nvim-0.10.0") == 1,
  },

  {
    "hrsh7th/nvim-cmp",
    config = function(_, opts)
      local cmp = require("cmp")
      local mappings = {
        ["<Up>"] = cmp.mapping.select_prev_item(),
        ["<Down>"] = cmp.mapping.select_next_item(),
        ["<Tab>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        }),
      }
      opts.mapping = vim.tbl_deep_extend("force", opts.mapping, mappings)
      opts.window = {
        completion = cmp.config.window.bordered({
          winhighlight = 'FloatBorder:CmpBorder',
          border = 'rounded'
        }),
        documentation = cmp.config.window.bordered({
          winhighlight = 'FloatBorder:CmpDocBorder',
          border = 'rounded'
        }),
      }
      cmp.setup(opts)
    end,
  }
}
