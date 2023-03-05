return {
  "rebelot/kanagawa.nvim",
  config = function()
    require("kanagawa").setup({
      transparent = true,
    })
    vim.cmd("colorscheme kanagawa")
    vim.api.nvim_set_hl(0, "Visual", { bg = "#41608c" })
    vim.api.nvim_set_hl(0, "Comment", { italic = true, fg = "#aba99d" })
  end,
}
