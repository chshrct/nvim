return {
  -- autotag
  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      autotag = {
        enable = true,
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  -- autopairs
  {
    "windwp/nvim-autopairs",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-autopairs").setup({})

      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")

      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },

  -- rainbow brackets
  {
    "mrjones2014/nvim-ts-rainbow",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-treesitter.configs").setup({
        rainbow = {
          enable = true,
          -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
          extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
          max_file_lines = nil, -- Do not enable for files with more than n lines, int
        },
      })
    end,
  },

  -- indent guides
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      char = "⋮",
      filetype_exclude = { "help", "neo-tree", "lazy" },
      show_trailing_blankline_indent = false,
      show_current_context = false,
    },
  },

  -- comments
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },

  -- surround
  {
    "kylechui/nvim-surround",
    version = false, -- Use for stability; omit to use `main` branch for the latest features
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },
}
