return {
  {
    "vimwiki/vimwiki",
    ft = {
      "markdown",
    },
    init = function()
      vim.g.vimwiki_global_ext = 1
      vim.g.vimwiki_table_mappings = 0
      vim.g.vimwiki_key_mappings = {
        links = 0,
      }
      -- vim.g.vimwiki_hl_headers = 1

      vim.g.vimwiki_list = {
        { path = vim.env["_F"], ext = ".md", syntax = "markdown" },
      }
      vim.g.vimwiki_ext2syntax = {
        [".md"] = "markdown",
        [".markdown"] = "markdown",
        [".wiki"] = "media",
      }
    end,
  },
}
