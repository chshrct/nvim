return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = false, -- last release is way too old and doesn't work on Windows
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
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
