return {
  enabled = true,
  "OXY2DEV/markview.nvim",
  lazy = false, -- Recommended
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons"
  },
  config = function()
    require("markview").setup({
      -- This combo makes it so everything is always 'rendered' prettily except the line
      -- being currently edited.
      modes = { "n", "i", "nc", "c", "v", },
      hybrid_modes = { "i" },

      list_items = {
        enable = false,
        indent_size = 2,
        shift_width = 2,
      },
      checkboxes = {
        enable = false,
      },
      headings = {
        heading_1 = { sign = "" },
        heading_2 = { sign = "" },
        heading_3 = { sign = "" },
      }
    })

    require("markview.extras.checkboxes").setup({
      --- When true, list item markers will
      --- be removed.
      remove_markers = true,

      --- If false, running the command on
      --- visual mode doesn't change the
      --- mode.
      exit = true,

      default_marker = "-",
      default_state = "X",

      --- A list of states
      states = {
        { " ", "X" },
        { "-", "o", "~" }
      }
    })

    -- TODO: Temp bindings. Move to keymaps file if finalized.
    vim.o.signcolumn = "no"
    vim.keymap.set("n", "<leader>mt", "<cmd>Markview toggle<cr>")
    vim.keymap.set("n", "<c-space>", "<cmd>CheckboxNext<cr>")
  end
}
