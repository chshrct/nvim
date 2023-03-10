return {

  -- search
  {
    "nvim-telescope/telescope.nvim",
    version = false,
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
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
        { "<leader>sk", builtin.keymaps, {} },

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
          extensions = {
            fzf = {
              fuzzy = true, -- false will only do exact matching
              override_generic_sorter = true, -- override the generic sorter
              override_file_sorter = true, -- override the file sorter
              case_mode = "smart_case", -- or "ignore_case" or "respect_case"
              -- the default case_mode is "smart_case"
            },
          },
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
      require("telescope").load_extension("fzf")
      vim.api.nvim_set_hl(0, "TelescopeBorder", {ctermbg = 222})
    end,
  },

  -- explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",
    keys = {
      { "<leader>te", ":Neotree toggle<CR>", { silent = true } },
      { "<leader>ef", ":Neotree<CR>", { silent = true } },
      {
        "<leader>eg",
        ":Neotree float git_status<CR>",
        { silent = true },
      },
      {
        "<leader>eb",
        ":Neotree buffers<CR>",
        { silent = true },
      },
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
          ["h"] = function(state)
            local node = state.tree:get_node()
            if node.type == "directory" and node:is_expanded() then
              require("neo-tree.sources.filesystem").toggle_directory(
                state,
                node
              )
            else
              require("neo-tree.ui.renderer").focus_node(
                state,
                node:get_parent_id()
              )
            end
          end,
          ["l"] = function(state)
            local node = state.tree:get_node()
            if node.type == "directory" then
              if not node:is_expanded() then
                require("neo-tree.sources.filesystem").toggle_directory(
                  state,
                  node
                )
              elseif node:has_children() then
                require("neo-tree.ui.renderer").focus_node(
                  state,
                  node:get_child_ids()[1]
                )
              end
            end
          end,
        },
      },
      filesystem = {
        follow_current_file = true, -- This will find and focus the file in the active buffer every
        group_empty_dirs = true, -- when true, empty folders will be grouped together
        hijack_netrw_behavior = "open_default",
      },
    },
    init = function() -- init is called on startup. i.e. no lazy.
      vim.g.neo_tree_remove_legacy_commands = 1
      if vim.fn.argc() >= 1 then
        vim.api.nvim_create_autocmd("UIEnter", {
          once = true,
          callback = function(_)
            for i = 0, vim.fn.argc() - 1 do -- check for all command line arguments
              local stat = vim.loop.fs_stat(vim.fn.argv(i))
              if stat and stat.type == "directory" then -- only if any of them is a dir
                require("neo-tree") -- require neo-tree, which asks lazy to load neo-tree which calls setup with `opts` and
                -- since hijack_netrw_behavior is set there, neo-tree overwrites netrw on setup
                return
              end
            end
          end,
        })
      end
      -- if no cl args or all are files, neo-tree is not loaded here and will wait lazily
    end,
  },
}
