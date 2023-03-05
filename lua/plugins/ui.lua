return {

  -- winbar
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    config = function()
      require("nvim-navic").setup({
        icons = {
          Null = " ",
          Namespace = " ",
          Package = " ",
          String = " ",
          Number = " ",
          Boolean = " ",
          Array = " ",
          Object = " ",
          Key = " ",
          Text = "  ",
          Method = "  ",
          Function = "  ",
          Constructor = "  ",
          Field = "  ",
          Variable = "  ",
          Class = "  ",
          Interface = "  ",
          Module = "  ",
          Property = "  ",
          Unit = "  ",
          Value = "  ",
          Enum = "  ",
          Keyword = "  ",
          Snippet = "  ",
          Color = "  ",
          File = "  ",
          Reference = "  ",
          Folder = "  ",
          EnumMember = "  ",
          Constant = "  ",
          Struct = "  ",
          Event = "  ",
          Operator = "  ",
          TypeParameter = "  ",
        },
      })
      require("barbecue").setup({
        create_autocmd = false, -- prevent barbecue from updating itself automatically
      })

      vim.api.nvim_create_autocmd({
        "WinResized", -- or WinResized on NVIM-v0.9 and higher
        "BufWinEnter",
        "CursorHold",
        "InsertLeave",

        -- include these if you have set `show_modified` to `true`
        "BufWritePost",
        "TextChanged",
        "TextChangedI",
      }, {
        group = vim.api.nvim_create_augroup("barbecue.updater", {}),
        callback = function()
          require("barbecue.ui").update()
        end,
      })
    end,
  },

  -- status line
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      opt = true,
    },
    opts = {
      options = {
        theme = "auto",
        globalstatus = true,
        disabled_filetypes = { statusline = { "lazy" } },
        icons_enabled = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = {
          {
            "filetype",
            icon_only = true,
            separator = "",
            padding = { left = 1, right = 0 },
          },
          {
            "filename",
            path = 1,
            symbols = { modified = "  ", readonly = "", unnamed = "" },
          },
        },
        lualine_x = {
          "encoding",
          {
            "fileformat",
          },
        },
        lualine_y = {
          {
            "progress",
            separator = "|",
          },
          { "location", padding = { left = 0, right = 1 } },
        },
        lualine_z = {
          function()
            return " " .. os.date("%R")
          end,
        },
      },
      extensions = { "neo-tree" },
    },
  },
}
