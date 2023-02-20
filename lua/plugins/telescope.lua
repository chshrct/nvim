return {
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.1',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local builtin = require('telescope.builtin')
      local findFiles = function()
        return builtin.find_files({
          no_ignore = true
        })
      end

      local actions = require("telescope.actions")
      require "telescope".setup {
        defaults = {
          mappings = {
            n = {
              ["d"] = actions.delete_buffer,
              ["<C-c>"] = actions.close,
            },
          },
        },
      }

      -- Search files and strings
      vim.keymap.set('n', '<leader>sf', findFiles, {})
      vim.keymap.set('n', '<leader>sg', builtin.git_files, {})
      vim.keymap.set('n', '<leader>ss', builtin.live_grep, {})
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, {})
      vim.keymap.set('n', '<leader>/', builtin.current_buffer_fuzzy_find, {})
      vim.keymap.set('n', '<leader>sb', builtin.buffers, {})

      -- Search LSP
      vim.keymap.set('n', '<leader>sr', builtin.lsp_references, {})
      vim.keymap.set('n', '<leader>sd', builtin.lsp_definitions, {})
      vim.keymap.set('n', '<leader>st', builtin.lsp_type_definitions, {})
      vim.keymap.set('n', '<leader>si', builtin.lsp_implementations, {})
      vim.keymap.set('n', '<leader>se', builtin.diagnostics, {})
      vim.keymap.set('n', '<leader>sa', builtin.lsp_workspace_symbols, {})
    end
  }
}
