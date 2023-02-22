-- better diagnostics list and others
return {

  -- search
  {
    "nvim-telescope/telescope.nvim",
    version = false,
    cmd = "Telescope",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = function()
      local builtin = require("telescope.builtin")

      local findFiles = function()
        return builtin.find_files({
          no_ignore = true,
        })
      end
      return {
        -- Search files and strings
        { "<leader>sf", findFiles, {} },
        { "<leader>so", builtin.oldfiles, {} },
        { "<leader>sb", builtin.buffers, {} },
        { "<leader>sg", builtin.git_files, {} },
        { "<leader>ss", builtin.live_grep, {} },
        { "<leader>sw", builtin.grep_string, {} },
        { "<leader>/", builtin.current_buffer_fuzzy_find, {} },

        -- Search utils
        { "<leader>sh", builtin.help_tags, {} },

        -- Search LSP
        { "<leader>sr", builtin.lsp_references, {} },
        { "<leader>sd", builtin.lsp_definitions, {} },
        { "<leader>st", builtin.lsp_type_definitions, {} },
        { "<leader>si", builtin.lsp_implementations, {} },
        { "<leader>se", builtin.diagnostics, {} },
        { "<leader>sa", builtin.lsp_dynamic_workspace_symbols, {} },
      }
    end,
    opts = function()
      local actions = require("telescope.actions")

      return {
        defaults = {
          prompt_prefix = "   ",
          selection_caret = " ",
          initial_mode = "insert",
          selection_strategy = "reset",
          sorting_strategy = "ascending",
          layout_strategy = "horizontal",
          layout_config = {
            horizontal = {
              prompt_position = "top",
              preview_width = 0.55,
              results_width = 0.8,
            },
            vertical = {
              mirror = false,
            },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
          },
          file_sorter = require("telescope.sorters").get_fuzzy_file,
          file_ignore_patterns = { "node_modules" },
          generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
          path_display = { "truncate" },
          winblend = 0,
          border = {},
          borderchars = {
            "─",
            "│",
            "─",
            "│",
            "╭",
            "╮",
            "╯",
            "╰",
          },
          color_devicons = true,
          set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
          file_previewer = require("telescope.previewers").vim_buffer_cat.new,
          grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
          qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
          -- Developer configurations: Not meant for general override
          buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
          mappings = {
            n = {
              ["bd"] = actions.delete_buffer,
              ["<C-c>"] = actions.close,
            },
          },
        },
      }
    end,
    config = function(_, opts)
      require("telescope").setup(opts)
    end,
  },

  -- diagnostics list
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    opts = { use_diagnostic_signs = true },
    keys = {
      {
        "<leader>dd",
        "<cmd>TroubleToggle document_diagnostics<cr>",
        desc = "Document Diagnostics (Trouble)",
      },
      {
        "<leader>dw",
        "<cmd>TroubleToggle workspace_diagnostics<cr>",
        desc = "Workspace Diagnostics (Trouble)",
      },
      {
        "<leader>dl",
        "<cmd>TroubleToggle loclist<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>dq",
        "<cmd>TroubleToggle quickfix<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },

  -- explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    opts = {
      window = {
        position = "right",
        mappings = {
          ["cr"] = {
            "toggle_node",
            nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
          },
          ["o"] = "open",
        },
      },
      filesystem = {
        follow_current_file = true, -- This will find and focus the file in the active buffer every
        group_empty_dirs = true, -- when true, empty folders will be grouped together
      },
    },
  },
}
