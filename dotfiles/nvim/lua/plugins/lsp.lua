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

      local augroup_lsp_formatting = vim.api.nvim_create_augroup("lsp_formatting", {})
      local handle_lsp_attach = function(client, bufnr)
        keymaps.set_common_lsp_keymaps(client, bufnr)

        -- Trigger formatting on save if available
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({
            group = augroup_lsp_formatting,
            buffer = bufnr,
          })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup_lsp_formatting,
            buffer = bufnr,
            callback = function()
              -- Code actions are non-blocking. That can cause race conditions when
              -- invoking the subsequent formatting call which we're doing in a sync
              -- manner. 
              -- TODO: Review if things have imporoved to be able to remove the
              -- `vim.wait()` call. This also spews a 'No code actions available' in
              -- messages. Fine for now, but can be noisy if we set up toast
              -- notifications for messages.
              vim.lsp.buf.code_action({
                context = { only = { "source.organizeImports"}},
                apply = true,
              })
              vim.wait(50)

              vim.lsp.buf.format({ bufnr = bufnr })
            end,
          })
        end
      end

      lsp.ruff_lsp.setup({
        on_attach = function(client, bufnr)
          client.server_capabilities.hoverProvider = false
          return handle_lsp_attach(client, bufnr)
        end,
        capabilities = capabilities,
      })

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
