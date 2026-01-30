return {
  {
    "nvim-mini/mini.surround",
    opts = {
      mappings = {
        add = "<leader>sa",
        delete = "<leader>sd",
        find = "<leader>sf",
        find_left = "<leader>sF",
        highlight = "<leader>sh",
        replace = "<leader>sR",
        pdate_n_lines = "<leader>sn",
      },
    },
  },
  -- add more treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },
    },
  },
  -- guess-indent
  {
    "nmac427/guess-indent.nvim",
  },
  -- highlight-undo
  {
    "tzachar/highlight-undo.nvim",
    opts = {
      hlgroup = "HighlightUndo",
      duration = 300,
      pattern = { "*" },
      ignored_filetypes = { "neo-tree", "fugitive", "TelescopePrompt", "mason", "lazy" },
      -- ignore_cb is in comma as there is a default implementation. Setting
      -- to nil will mean no default os called.
      -- ignore_cb = nil,
    },
  },
  {
    "ErichDonGubler/lsp_lines.nvim",
  },
  { "shortcuts/no-neck-pain.nvim" },
  {
    'MagicDuck/grug-far.nvim',
    -- Note (lazy loading): grug-far.lua defers all it's requires so it's lazy by default
    -- additional lazy config to defer loading is not really needed...
    config = function()
      -- optional setup call to override plugin options
      -- alternatively you can set options with vim.g.grug_far = { ... }
      require('grug-far').setup({
        -- options, see Configuration section below
        -- there are no required options atm
      });
    end
  },
}
