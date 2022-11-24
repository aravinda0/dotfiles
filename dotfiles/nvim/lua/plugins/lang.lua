local cmp = require("cmp")
local lsp = require("lspconfig")
local luasnip = require("luasnip")
local null_ls = require("null-ls")

local keymaps = require("keymaps")

local M = {}

local augroup_lsp_formatting = vim.api.nvim_create_augroup("lsp_formatting", {})

local setup_cmp = function()
  cmp.setup({
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    mapping = keymaps.build_nvim_cmp_config_keymaps(),
    sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "path" },
      { name = "luasnip" },
    }, {
      { name = "buffer" },
    }),
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work
  -- anymore).
  cmp.setup.cmdline(":", {
    sources = cmp.config.sources({
      { name = "path" },
    }, {
      { name = "cmdline" },
    }),
  })
end

local setup_snippets = function()
  -- TODO: Generalize this code to look in snippets dir and auto-load
  local python_snippets = require("snippets.luasnip.python")
  local rust_snippets = require("snippets.luasnip.rust")

  luasnip.add_snippets("python", python_snippets.python)
  luasnip.add_snippets("rust", rust_snippets.rust)

  -- Lazy load general snippets and custom ones
  require("luasnip.loaders.from_vscode").lazy_load()
end

local setup_lsp = function()
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

  lsp.sumneko_lua.setup({
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
end

local setup_null_ls = function()
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
      null_ls.builtins.formatting.trim_whitespace,

      null_ls.builtins.formatting.black,
      null_ls.builtins.formatting.isort,

      null_ls.builtins.formatting.stylua,
    },
    on_attach = handle_lsp_attach,
  })
end

M.setup = function()
  setup_cmp()
  setup_snippets()
  setup_lsp()
  setup_null_ls()
end

return M
