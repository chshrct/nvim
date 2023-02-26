return {
  "jose-elias-alvarez/null-ls.nvim",
  config = function()
    local present, null_ls = pcall(require, "null-ls")

    if not present then
      return
    end

    local b = null_ls.builtins

    local sources = {
      -- JS
      b.formatting.prettierd,
      b.diagnostics.eslint_d,
      b.code_actions.eslint_d,

      -- Lua
      b.formatting.stylua,
    }

    null_ls.setup({
      sources = sources,
    })
  end,
}
