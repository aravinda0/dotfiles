return {
  'stevearc/conform.nvim',
  opts = {
     formatters_by_ft = {
        rust = { "rustfmt", lsp_format = "fallback" },
        python = { "ruff_format", "ruff_organize_imports" },
        lua = { "stylua" },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        html = { "prettierd", "prettier", stop_after_first = true },
        css = { "prettierd", "prettier", stop_after_first = true },
        yaml = { "yamlfmt" },
     },
     format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
     }
  },
}
