local keymaps = require("keymaps")

-- LSP config docs: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#pyright
return {
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local lsp = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local handle_lsp_attach = function(client, bufnr)
        keymaps.set_common_lsp_keymaps(client, bufnr)
      end

      lsp.pyright.setup({
        on_attach = handle_lsp_attach,
        capabilities = capabilities,
      })

      lsp.rust_analyzer.setup({
        on_attach = handle_lsp_attach,
        capabilities = capabilities,
      })

      lsp.tsserver.setup({
        on_attach = handle_lsp_attach,
        capabilities = capabilities,
      })

      lsp.angularls.setup({
        on_attach = handle_lsp_attach,
        capabilities = capabilities,
      })

      -- lsp.tailwindcss.setup({
      --   on_attach = handle_lsp_attach,
      --   capabilities = capabilities,
      -- })

      lsp.lua_ls.setup({
        on_attach = handle_lsp_attach,
        capabilities = capabilities,
        -- specific to nvim development for now
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
              enable = false,
            },
          },
        },
      })
    end,
  },
}
