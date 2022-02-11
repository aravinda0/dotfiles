
call plug#begin()

" -------------------------------------------------------------------------------
" LSP and language servers
" -------------------------------------------------------------------------------
" - neovim LSP docs:
"   - https://neovim.io/doc/user/lsp.html
" - UI customizations:
"   - https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization
" -------------------------------------------------------------------------------

Plug 'neovim/nvim-lspconfig', { 'do': 'npm i -g pyright' }

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
  autocmd BufWritePre *.py execute ':Black'
augroup END


" -------------------------------------------------------------------------------
" Autocomplete
" -------------------------------------------------------------------------------

Plug 'ms-jpq/coq_nvim', { 'branch': 'coq' }
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}

" coq settings:
" - auto_start: Autostart completion. This needs to be set before `require("coq")`.
" - keymap.recommended: `true` by default and gives us some mappings.
" - keymap.bigger_preview: By default, mapped to `<c-k>` which conflicts with my motion
"   mappings. Need to reset it here, else our mappings don't take effect.
" - keymap.jump_to_mark: TODO: Setting to `<Tab>` leads to `Tab` not working in general
"   usage. Current assignment is default.
let g:coq_settings = {
      \ 'auto_start': v:true,
      \ 'keymap.recommended': v:false,
      \ 'keymap.bigger_preview': '<c-m-k>',
      \ 'keymap.jump_to_mark': '<c-n>',
      \ 'keymap.pre_select': v:false,
      \ 'clients.snippets.user_path': $DOTFILES_PATH . '/nvim/custom_snippets/coq'
  \ }

" Additional bindings beyond the built-in bindings
inoremap <silent><expr> <c-j>   pumvisible() ? "\<C-n>" : "\<c-j>"
inoremap <silent><expr> <c-k> pumvisible() ? "\<C-p>" : "\<c-k>"
" inoremap <silent><expr> <tab> pumvisible() ? (complete_info().selected == -1 ? "\<c-e>\<tab>" : "\<c-y>") : "\<tab>"
inoremap <silent><expr> <c-e> pumvisible() ? (complete_info().selected == -1 ? "\<c-e><tab>" : "\<c-y>") : "<end>"
inoremap <silent><expr> <c-c> pumvisible() ? "\<C-e><c-c>" : "\<c-c>"
inoremap <silent><expr> <cr> "\<cr>"



" -------------------------------------------------------------------------------
" Auto pairs
" -------------------------------------------------------------------------------

Plug 'windwp/nvim-autopairs'


" -------------------------------------------------------------------------------
" Fuzzy searcher
" -------------------------------------------------------------------------------

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'branch': 'main', 'do': 'make' }

nnoremap <c-p> <cmd>Telescope find_files<cr>
nnoremap <c-o> <cmd>Telescope buffers<cr>
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
nnoremap <c-l>caa <cmd>Telescope lsp_code_actions<cr>
nnoremap <c-l>car <cmd>Telescope lsp_range_code_actions<cr>
nnoremap <c-l>d <cmd>Telescope lsp_definitions<cr>
nnoremap <c-l>t <cmd>Telescope lsp_type_definitions<cr>
nnoremap <c-l>D <cmd>Telescope lsp_document_diagnostics<cr>
nnoremap <c-l>0 <cmd>Telescope treesitter<cr>

" git helpers
nnoremap <c-g>f <cmd>Telescope git_files<cr>
nnoremap <c-g>c <cmd>Telescope git_commits<cr>
nnoremap <c-g>bc <cmd>Telescope git_bcommits<cr>
nnoremap <c-g>br <cmd>Telescope git_branches<cr>
nnoremap <c-g>s <cmd>Telescope git_status<cr>
nnoremap <c-g>a <cmd>Telescope git_stash<cr>


" -------------------------------------------------------------------------------
" Cursor motion
" -------------------------------------------------------------------------------

Plug 'phaazon/hop.nvim'

nnoremap s <c-o>:HopChar2<cr>
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

lua << EOF
local lsp = require("lspconfig")
local coq = require("coq")

-- Use an on_attach function to only map the following keys after the language server
-- attaches to the current buffer.
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  buf_set_keymap("n", "<leader>k", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  buf_set_keymap("n", "<leader>t", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
  buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
  buf_set_keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  buf_set_keymap("n", "<leader>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
  buf_set_keymap("n", "<leader>d", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
  buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  buf_set_keymap("n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  buf_set_keymap("n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
  buf_set_keymap("n", "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
end

-- Use a loop to conveniently call `setup` on multiple servers and map buffer local
-- keybindings when the language server attaches.
-- Also ensure `coq_nvim` completion is enabled for each server.
local servers = {
  "pyright",
  "rust_analyzer",
}
for _, server in ipairs(servers) do
  lsp[server].setup(coq.lsp_ensure_capabilities({
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }))
end
EOF


lua <<EOF
require("nvim-treesitter.configs").setup({
  ensure_installed = "maintained",
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
        ["ic"] = "@class.outer",
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
