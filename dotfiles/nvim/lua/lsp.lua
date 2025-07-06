-- ----------------------------------------------------------------------------------------
-- NOTE: We just extend various LSP server configs here. The defaults are loaded in from
-- the `nvim-lspconfig` plugin, used as a data-only plugin.
-- ----------------------------------------------------------------------------------------


vim.api.nvim_create_autocmd("LspAttach", {
   group = vim.api.nvim_create_augroup("lsp_attach_stuff", { clear = true }),
   callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client == nil then
         return
      end
      if client.name == "ruff" then
         -- Disable hover in favor of pyright
         client.server_capabilities.hoverProvider = false
      end
   end
})

vim.lsp.config("rust_analyzer", {
   settings = {
      ["rust-analyzer"] = {
         checkOnSave = true,
         procMacro = {
            enable = true,
            ignored = {
               ["async-trait"] = { "async_trait" },
               ["napi-derive"] = { "napi" },
               ["async-recursion"] = { "async_recursion" },
            },
         },
      },
   },
})
vim.lsp.enable("rust_analyzer")


vim.lsp.config("ruff", {})
vim.lsp.enable("ruff")


vim.lsp.config("basedpyright", {
   settings = {
      pyright = {
         -- Using ruff instead.
         disableOrganizeImports = true,
      },
      python = {
         analysis = {
            -- Using ruff instead.
            ignore = { "*" }
         }
      }
   }
})
vim.lsp.enable("basedpyright")


vim.lsp.config("ts_ls", {})
vim.lsp.enable("ts_ls")

vim.lsp.config("svelte", {})
vim.lsp.enable("svelte")

-- vim.lsp.config("tailwindcss", {})
-- vim.lsp.enable("tailwindcss")


vim.lsp.config('lua_ls', {
   on_init = function(client)
      if client.workspace_folders then
         local path = client.workspace_folders[1].name
         if
             path ~= vim.fn.stdpath('config')
             and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
         then
            return
         end
      end

      client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
         runtime = {
            version = 'LuaJIT',
            -- Tell the language server how to find Lua modules same way as Neovim
            -- (see `:h lua-module-load`)
            path = {
               'lua/?.lua',
               'lua/?/init.lua',
            },
         },
         -- Make the server aware of Neovim runtime files
         workspace = {
            checkThirdParty = false,
            library = {
               vim.env.VIMRUNTIME
               -- Depending on the usage, you might want to add additional paths
               -- here.
               -- '${3rd}/luv/library'
               -- '${3rd}/busted/library'
            }
            -- Or pull in all of 'runtimepath'.
            -- NOTE: this is a lot slower and will cause issues when working on
            -- your own configuration.
            -- See https://github.com/neovim/nvim-lspconfig/issues/3189
            -- library = {
            --   vim.api.nvim_get_runtime_file('', true),
            -- }
         }
      })
   end,
   settings = {
      Lua = {}
   }
})
vim.lsp.enable('lua_ls')


-- TODO: This is a workaround to deal with some race condition where the LSP stuff
-- doesn't start without triggering a file reload via `:e`.
-- Need to look into this to find a better way or fix any root cause.
vim.api.nvim_exec_autocmds("FileType", {})
