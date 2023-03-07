return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = false, -- last release is way too old and doesn't work on Windows
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      after = "nvim-treesitter/nvim-treesitter",
    },
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    keys = {
      { "<leader>v", desc = "Increment selection" },
      { "<leader>V", desc = "Schrink selection", mode = "x" },
    },
    opts = {
      auto_install = true,
      highlight = { enable = true, use_languagetree = true },
      indent = { enable = true, disable = { "python" } },
      context_commentstring = { enable = true, enable_autocmd = false },
      ensure_installed = {
        "help",
        "lua",
        "markdown",
        "markdown_inline",
        "regex",
        "vim",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<leader>v",
          node_incremental = "<leader>v",
          scope_incremental = "<nop>",
          node_decremental = "<leader>V",
        },
      },
      textobjects = {
        swap = {
          enable = true,
          swap_next = {
            ["<leader>>"] = "@parameter.inner",
          },
          swap_previous = {
            ["<leader><"] = "@parameter.inner",
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            ["]f"] = "@function.inner",
            ["]c"] = "@class.inner",
            ["]a"] = "@parameter.inner",
            ["]r"] = "@return.inner",
          },
          goto_previous_start = {
            ["[f"] = "@function.inner",
            ["[c"] = "@class.inner",
            ["[a"] = "@parameter.inner",
            ["[r"] = "@return.inner",
          },
        },
        select = {
          enable = true,
          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,

          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",
            ["ar"] = "@return.outer",
            ["ir"] = "@return.inner",
          },
          include_surrounding_whitespace = true,
        },
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
