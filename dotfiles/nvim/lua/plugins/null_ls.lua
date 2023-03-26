return {
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "BufReadPre",
    config = function()
      local null_ls = require("null-ls")

      local augroup_lsp_formatting = vim.api.nvim_create_augroup("lsp_formatting", {})
      local handle_lsp_attach = function(client, bufnr)
        -- Set things up to invoke formatters automatically on save
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({
            group = augroup_lsp_formatting,
            buffer = bufnr,
          })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup_lsp_formatting,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ bufnr = bufnr })
            end,
          })
        end
      end

      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.trim_whitespace.with({
            disabled_filetypes = {
              "python", -- `black` takes care of it
            },
          }),

          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.ruff,
          null_ls.builtins.diagnostics.ruff,

          null_ls.builtins.diagnostics.sqlfluff.with({
            extra_args = { "--dialect", "postgres" },
          }),

          null_ls.builtins.formatting.prettierd,

          null_ls.builtins.formatting.rustywind,

          null_ls.builtins.formatting.stylua,

          -- Nice in general, but interferes with fancypantsness of modern UI libs
          -- null_ls.builtins.diagnostics.tidy,
          -- null_ls.builtins.formatting.tidy,
        },
        on_attach = handle_lsp_attach,
      })
    end,
  },
}
