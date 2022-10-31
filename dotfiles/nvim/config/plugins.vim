
call plug#begin()


" -------------------------------------------------------------------------------
" LSP and language servers
" -------------------------------------------------------------------------------
" - neovim LSP docs:
"   - https://neovim.io/doc/user/lsp.html
" - UI customizations:
"   - https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization
" -------------------------------------------------------------------------------

Plug 'neovim/nvim-lspconfig', { 'do': 'npm i -g pyright typescript typescript-language-server' }

" lua <<EOF
" -- You will likely want to reduce updatetime which affects CursorHold
" -- note: this setting is global and should be set only once
" vim.o.updatetime = 250
" vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
" EOF


" -------------------------------------------------------------------------------
" Syntax, highlight, formatting, indent etc
" -------------------------------------------------------------------------------

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'

Plug 'lukas-reineke/indent-blankline.nvim'

" Treesitter indent support is not yet up to the mark in many cases
Plug 'Vimjas/vim-python-pep8-indent', { 'for': 'python' }

" TODO: Review approaches via LSP. eg. `efm-langserver`, which I couldn't figure out.
Plug 'psf/black', { 'branch': 'main' }

augroup PluginAutoFormatters
  autocmd!
  autocmd BufWritePre *.py Black
augroup END


" -------------------------------------------------------------------------------
" Autocomplete
" -------------------------------------------------------------------------------
" - nvim-cmp docs:
"   - https://github.com/hrsh7th/nvim-cmp
" - lsp_signature docs:
"   - https://github.com/ray-x/lsp_signature.nvim
" -------------------------------------------------------------------------------

" nvim-cmp and completion sources
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

" nvim-cmp says signature hints support is out-of-scope, since it's not part of the LSP
" spec. This plugin is recommended.
Plug 'ray-x/lsp_signature.nvim'


" -------------------------------------------------------------------------------
" Snippets
" -------------------------------------------------------------------------------
"  LuaSnip Docs:
"   - https://github.com/L3MON4D3/LuaSnip
"   - https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md
"   - Sample snippets:
"     - https://github.com/L3MON4D3/LuaSnip/blob/b5a72f1fbde545be101fcd10b70bcd51ea4367de/Examples/snippets.lua
" -------------------------------------------------------------------------------

Plug 'L3MON4D3/LuaSnip'

" Sources for nvim-cmp
Plug 'saadparwaiz1/cmp_luasnip'

" Snippet collections
Plug 'rafamadriz/friendly-snippets'


" -------------------------------------------------------------------------------
" Auto pairs
" -------------------------------------------------------------------------------

Plug 'windwp/nvim-autopairs'


" -------------------------------------------------------------------------------
" Fuzzy searcher
" -------------------------------------------------------------------------------

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

nnoremap <c-p> <cmd>Telescope find_files<cr>
nnoremap <c-o> <cmd>Telescope buffers sort_mru=true<cr>
nnoremap <c-t>/ <cmd>Telescope live_grep<cr>
nnoremap <c-t>* <cmd>Telescope grep_string<cr>
nnoremap <c-t>f <cmd>Telescope file_browser<cr>
nnoremap <c-t>: <cmd>Telescope commands<cr>
nnoremap <c-t>h <cmd>Telescope help_tags<cr>
nnoremap <c-t>m <cmd>Telescope keymaps<cr>

" LSP helpers. Also check `lspconfig` mappings.
nnoremap <c-l>r <cmd>Telescope lsp_references<cr>
nnoremap <c-l>s <cmd>Telescope lsp_document_symbols<cr>
nnoremap <c-l>wss <cmd>Telescope lsp_workspace_symbols<cr>
nnoremap <c-l>wsd <cmd>Telescope lsp_dynamic_workspace_symbols<cr>
nnoremap <c-l>ic <cmd>Telescope lsp_incoming_calls<cr>
nnoremap <c-l>oc <cmd>Telescope lsp_outcoming_calls<cr>
nnoremap <c-l>d <cmd>Telescope diagnostics<cr>

" git helpers
nnoremap <c-g>f <cmd>Telescope git_files<cr>
nnoremap <c-g>c <cmd>Telescope git_commits<cr>
nnoremap <c-g>bc <cmd>Telescope git_bcommits<cr>
nnoremap <c-g>br <cmd>Telescope git_branches<cr>
nnoremap <c-g>s <cmd>Telescope git_status<cr>
nnoremap <c-g>a <cmd>Telescope git_stash<cr>

nnoremap <c-l>0 <cmd>Telescope treesitter<cr>


" -------------------------------------------------------------------------------
" Cursor motion
" -------------------------------------------------------------------------------

Plug 'phaazon/hop.nvim'

nnoremap s <cmd>HopChar2<cr>
nnoremap <leader>sw <c-o>:HopWord<cr>
nnoremap <leader>sl <c-o>:HopLine<cr>


" -------------------------------------------------------------------------------
" Surround
" -------------------------------------------------------------------------------

Plug 'tpope/vim-surround'


" -------------------------------------------------------------------------------
" Status line
" -------------------------------------------------------------------------------

Plug 'nvim-lualine/lualine.nvim'


" -------------------------------------------------------------------------------
" Comments
" -------------------------------------------------------------------------------

Plug 'numToStr/Comment.nvim'


" -------------------------------------------------------------------------------
" Note Taking
" -------------------------------------------------------------------------------

Plug 'vimwiki/vimwiki'

" TODO: After trial phase, fetch notes path from env var
let g:vimwiki_list = [
      \ {'path': '~/.dency/forge/notes', 'ext': '.md', 'syntax': 'markdown'},
      \ {'path': '~/.dency/brain', 'ext': '.md', 'syntax': 'markdown'},
      \ {'path': '~/.dency/old_notes/wiki/.j/todo', 'ext': '.md', 'syntax': 'markdown'},
      \ {'path': '~/.dency/old_notes/wiki/.j', 'ext': '.md', 'syntax': 'markdown'}
  \ ]

" Handle various file types with appropriate syntax settings
let g:vimwiki_ext2syntax = {
      \ '.md': 'markdown',
      \ '.mkd': 'markdown',
      \ '.wiki': 'media'
  \ }

" Need to use `namp` and not `nnoremap`
augroup PluginVimWikiMappings
  autocmd!
  autocmd FileType vimwiki,markdown nmap <buffer> gv <Plug>VimwikiVSplitLink
  autocmd FileType vimwiki,markdown nmap <buffer> gx <Plug>VimwikiSplitLink
  autocmd FileType vimwiki,markdown nmap <buffer> go <Plug>VimwikiFollowLink
  autocmd FileType vimwiki,markdown nmap <buffer> gt <Plug>VimwikiTabnewLink
  autocmd FileType vimwiki,markdown nmap <buffer> gb <Plug>VimwikiGoBackLink

  " Bring back our backspace mapping that vimwiki overrides
  autocmd FileType vimwiki,markdown nmap <buffer> <bs> :b#<cr>
augroup END

let g:vimwiki_table_mappings = 0


" -------------------------------------------------------------------------------
" Session management
" -------------------------------------------------------------------------------
" Docs:
"   https://github.com/rmagatti/auto-session
"   https://github.com/rmagatti/session-lens
" -------------------------------------------------------------------------------

Plug 'rmagatti/auto-session'
Plug 'rmagatti/session-lens'


nnoremap <c-t>s <cmd>SearchSession<cr>

" -------------------------------------------------------------------------------
" Color scheme
" -------------------------------------------------------------------------------

Plug 'sainnhe/gruvbox-material'

let g:gruvbox_material_background = 'hard'

" -------------------------------------------------------------------------------


" Initialize plugin system
call plug#end()


" ---------------------------------------------------------------------------
" These settings have to be configured after `plug#end` has been called
" ---------------------------------------------------------------------------

set background=dark
colorscheme gruvbox-material


" ---------------------------------------------------------------------------
" LSP and related config after `plug#end` is called and plugins are initialized.
" Else would throw error when opening vim - on things like `require(<module>)`
" ---------------------------------------------------------------------------

lua <<EOF
require("nvim-treesitter.configs").setup({
  ensure_installed = "all",
  sync_install = false,
  highlight = {
    enable = true,
  },
  -- `indent` is experimental. Disabled for some langs.
  -- Track issues:
  --  - https://github.com/nvim-treesitter/nvim-treesitter/issues/1136
  indent = {
    enable = true,
    disable = { "python", "yaml" }
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      }
    }
  }
})

vim.cmd [[
  highlight DiagnosticLineNrError guibg=#51202A guifg=#FF0000 gui=bold
  highlight DiagnosticLineNrWarn guibg=#51412A guifg=#FFA500 gui=bold
  highlight DiagnosticLineNrInfo guibg=#1E535D guifg=#00FFFF gui=bold
  highlight DiagnosticLineNrHint guibg=#1E205D guifg=#0000FF gui=bold

  sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=DiagnosticLineNrError
  sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=DiagnosticLineNrWarn
  sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=DiagnosticLineNrInfo
  sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=DiagnosticLineNrHint
]]
EOF


lua << EOF
-- Configure LSP and related plugins that need to hook into LSP.

local lsp = require("lspconfig")
local cmp = require("cmp")
local luasnip = require("luasnip")

-- Load custom snippets
-- TODO: Generalize this code to look in snippets dir and auto-load
local python_snippets = require("snippets.luasnip.python")
local rust_snippets = require("snippets.luasnip.rust")

luasnip.add_snippets("python", python_snippets.python)
luasnip.add_snippets("rust", rust_snippets.rust)

-- Lazy load general snippets and custom ones
require("luasnip.loaders.from_vscode").lazy_load()

-- `:h vim.diagnostic.*`
local key_opts = { noremap=true, silent=true }
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, key_opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, key_opts)
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, key_opts)

-- Use an on_attach function to only map the following keys after the language server
-- attaches to the current buffer.
local on_attach = function(client, bufnr)
  local buf_opts = { noremap=true, silent=true, buffer=bufnr }

  -- `:h vim.lsp.*`
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, buf_opts)
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, buf_opts)
  vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, buf_opts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, buf_opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, buf_opts)
  vim.keymap.set("n", "<leader>k", vim.lsp.buf.signature_help, buf_opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, buf_opts)
  vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, buf_opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, buf_opts)
  vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, buf_opts)
  vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, buf_opts)
  vim.keymap.set("n", "<leader>wl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, buf_opts)
end

-- Configure nvim-cmp and luasnip
cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<c-j>"] = cmp.mapping.select_next_item(),
    ["<c-k>"] = cmp.mapping.select_prev_item(),
    ["<c-space>"] = cmp.mapping.complete(),
    -- ["<c-e>"] = cmp.mapping.confirm({ select = true}),
    ["<c-f>"] = cmp.mapping(function(fallback)
      if luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, {"i", "s"}),
    ["<c-b>"] = cmp.mapping(function(fallback)
      if luasnip.get_active_snip() and luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {"i", "s"}),
    ["<c-n>"] = cmp.mapping(function(fallback)
      if luasnip.choice_active() then
        luasnip.change_choice(1)
      else
        fallback()
      end
    end, {"i", "s"}),
    ["<c-p>"] = cmp.mapping(function(fallback)
      if luasnip.choice_active() then
        luasnip.change_choice(-1)
      else
        fallback()
      end
    end, {"i", "s"}),
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "path" },
    { name = "luasnip" },
  }, {
    { name = "buffer" },
  })
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = "path" }
  }, {
    { name = "cmdline" }
  })
})


-- `nvim-cmp` capabilities for each language server.
local capabilities = require("cmp_nvim_lsp").default_capabilities();

lsp.pyright.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

lsp.rust_analyzer.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

lsp.tsserver.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

EOF


lua <<EOF
require("lsp_signature").setup({
  bind = true,
  handler_opts = {
    border = "rounded",
  }
})
EOF

lua <<EOF
require("indent_blankline").setup({
  filetype_exclude = { "markdown", "vimwiki" }
})
EOF


lua <<EOF
require("nvim-autopairs").setup({
  check_ts = true,
})
EOF


lua <<EOF
local telescope = require("telescope")
local actions = require("telescope.actions")

telescope.setup{
  defaults = {
    file_ignore_patterns = {
      "__pycache__",
      "%.pyc",
      "node_modules",
    },
    mappings = {
      -- default mappings: https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/mappings.lua
      -- actions: https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/actions/init.lua
      i = {
        ["<c-j>"] = actions.move_selection_next,
        ["<c-k>"] = actions.move_selection_previous,
      }
    }
  },
}

require("telescope").load_extension("fzf")
EOF


lua <<EOF
require("hop").setup()
EOF


lua <<EOF
require("lualine").setup({
  sections = {
    lualine_a = {"mode"},
    lualine_b = {"branch", "diff", {"diagnostics", sources={"nvim_diagnostic"}}},
    lualine_c = {{"filename", file_status = true, path = 1, shorting_target = 30}},
    lualine_x = {"encoding", "filetype"},
    lualine_y = {"progress"},
    lualine_z = {"location"}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {{"diagnostics", sources={"nvim_diagnostic"}}},
    lualine_c = {{"filename", file_status = true, path = 1, shorting_target = 30}},
    lualine_x = {"location"},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
})
EOF


lua <<EOF
require("Comment").setup()
EOF


lua <<EOF
require('auto-session').setup({
  auto_session_suppress_dirs = {"~/.dency/forge/notes"},
  auto_session_root_dir = os.getenv("HOME").."/.vim_sessions/",
})

require("telescope").load_extension("session-lens")
require('session-lens').setup { }
EOF
