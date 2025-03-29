local M = {}

-- Use the space bar as our leader key
vim.g.mapleader = " "

vim.keymap.set("i", "jk", "<esc>")

-- Access plugin manager
vim.keymap.set("n", "<f12>", "<cmd>Lazy<cr>")

-- Workaround to allow pasting the same line multiple times in visual mode
vim.keymap.set("x", "p", "pgvy")
vim.keymap.set("x", "P", "Pgvy")

-- Nicer window motions
vim.keymap.set("n", "<m-h>", "<c-w>h")
vim.keymap.set("n", "<m-j>", "<c-w>j")
vim.keymap.set("n", "<m-k>", "<c-w>k")
vim.keymap.set("n", "<m-l>", "<c-w>l")

-- Easier resizing of splits. Increase/decrease pane size (unlike tmux's
-- border-movement-based resizing).
vim.keymap.set("n", "<c-a-->", "<cmd>vertical resize -5<cr>")
vim.keymap.set("n", "<c-a-=>", "<cmd>vertical resize +5<cr>")
vim.keymap.set("n", "<c-a-,>", "<cmd>resize -5<cr>")
vim.keymap.set("n", "<c-a-.>", "<cmd>resize +5<cr>")

-- Nicer tab operations
vim.keymap.set("n", "<m-t>", "<cmd>tabnew<cr>")
vim.keymap.set("n", "<m-e>", "<cmd>tabprevious<cr>")
vim.keymap.set("n", "<m-r>", "<cmd>tabnext<cr>")
vim.keymap.set("n", "<m-E>", "<cmd>tabfirst<cr>")
vim.keymap.set("n", "<m-R>", "<cmd>tablast<cr>")
local select_nth_tab = function(n)
   local tabs = vim.api.nvim_list_tabpages()
   if n > 0 and n <= #tabs then
      vim.api.nvim_set_current_tabpage(tabs[n])
   end
end
vim.keymap.set("n", "<m-1>", function() select_nth_tab(1) end)
vim.keymap.set("n", "<m-2>", function() select_nth_tab(2) end)
vim.keymap.set("n", "<m-3>", function() select_nth_tab(3) end)
vim.keymap.set("n", "<m-4>", function() select_nth_tab(4) end)
vim.keymap.set("n", "<m-5>", function() select_nth_tab(5) end)

-- Switch to previous buffer
vim.keymap.set("n", "<bs>", "<cmd>b#<cr>")

-- Save easily. May require disabling terminal suspend by adding `stty -ixon` to shell
-- startup script
vim.keymap.set({ "n", "v", "i" }, "<c-s>", "<cmd>update<cr>")

-- Reload file forcefully, discarding changes
vim.keymap.set("n", "<leader>rr", "<cmd>e!<cr>")

-- Prevent disasters
vim.keymap.set("n", "ZZ", "<nop>")

-- Quit easily
vim.keymap.set("n", "<leader>q", "<cmd>quit<cr>")
vim.keymap.set("n", "<leader>Q", "<cmd>qa!<cr>")

-- emacs-esque bindings for BOL/EOL
vim.keymap.set({ "i", "c" }, "<c-a>", "<home>")
vim.keymap.set({ "i", "c" }, "<c-e>", "<end>")

-- Easier history navigation in command mode
vim.keymap.set("c", "<c-k>", "<up>")
vim.keymap.set("c", "<c-j>", "<down>")

-- Easier indenting in visual mode
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Move lines up or down
-- TODO: Translate the visual mode mappings to lua properly. Stuff after `<cr>` doesn't
-- seem to register, even in an expr mapping.
vim.keymap.set("n", "<c-m-k>", "<cmd>move -2<cr>")
vim.keymap.set("n", "<c-m-j>", "<cmd>move +1<cr>")
vim.cmd("vnoremap <c-m-j> :move '>+1<cr>gv-gv")
vim.cmd("vnoremap <c-m-k> :move '<-2<cr>gv-gv")

-- Clear highlighting
vim.keymap.set("n", "<leader>n", "<cmd>nohl<cr>")

-- Open files in the same directory as the current file
-- TODO: Translate to lua
vim.cmd("noremap <leader>oe :e <c-r>=expand('%:p:h') . '/' <cr>")
vim.cmd("noremap <leader>ov :vsplit <c-r>=expand('%:p:h') . '/' <cr>")
vim.cmd("noremap <leader>ox :split <c-r>=expand('%:p:h') . '/' <cr>")
vim.cmd("noremap <leader>ot :tabe <c-r>=expand('%:p:h') . '/' <cr>")

-- Select previously pasted text
vim.keymap.set("n", "gp", function()
   return "'[" .. vim.fn.strpart(vim.fn.getregtype(), 0, 1) .. "']"
end, { expr = true })

-- --------------------------------------------------------------------------------
-- Abbreviations
-- --------------------------------------------------------------------------------

-- Separators
vim.cmd(
   "iabbrev --$ ----------------------------------------------------------------------------------------"
)
vim.cmd("iabbrev ---$ ----------")

-- Symbols
vim.cmd("iabbrev ki$ 💡")
vim.cmd("iabbrev tt$ 🧪")
vim.cmd("iabbrev wip$ 🚧")
vim.cmd("iabbrev fire$ 🔥")
vim.cmd("iabbrev eg$ 🥚")
vim.cmd("iabbrev tb$ 💭")
vim.cmd("iabbrev ang$ 💢")
vim.cmd("iabbrev no$ 🚫")
vim.cmd("iabbrev rx$ ❌")
vim.cmd("iabbrev rf$ 🚩")
vim.cmd("iabbrev tick$ ✅")
vim.cmd("iabbrev bana$ 🍌")
vim.cmd("iabbrev cr$ 🔴")
vim.cmd("iabbrev cb$ 🔵")
vim.cmd("iabbrev ck$ 🍪")
vim.cmd("iabbrev book$ 📖")
vim.cmd("iabbrev case$ 💼")
vim.cmd("iabbrev rice$ 🍚")
vim.cmd("iabbrev eye$ 👀")
vim.cmd("iabbrev lcoat$ 🥼")
vim.cmd("iabbrev tf$ 🤔")
vim.cmd("iabbrev cf$ 🫤")
vim.cmd("iabbrev ff$ 🙁")
vim.cmd("iabbrev hand$ 🤚")
vim.cmd("iabbrev pin$ 📍")
vim.cmd("iabbrev tri$ 🔱")
vim.cmd("iabbrev ep$ 🍆")
vim.cmd("iabbrev pray$ 🙏")
vim.cmd("iabbrev chore$ 🧹")
vim.cmd("iabbrev gem$ 💎")
vim.cmd("iabbrev sap$ 🌱")
vim.cmd("iabbrev tree$ 🌳")
vim.cmd("iabbrev tree2$ 🌲")
vim.cmd("iabbrev treep$ 🌴")
vim.cmd("iabbrev rkt$ 🚀")
vim.cmd("iabbrev pill$ 💊")
vim.cmd("iabbrev flow$ 🌻")
vim.cmd("iabbrev zk$ 🧠")
vim.cmd("iabbrev vom$ 🤮")
vim.cmd("iabbrev ts$ 🔭")
vim.cmd("iabbrev df$ 🫥")
vim.cmd("iabbrev sk$ 💀")
vim.cmd("iabbrev bone$ 🦴")
vim.cmd("iabbrev piz$ 🍕")


-- --------------------------------------------------------------------------------
-- Diagnostics
-- --------------------------------------------------------------------------------

-- These are defaults as of nvim 0.10.
vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end)
vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end)
vim.keymap.set("n", "<c-w>d", vim.diagnostic.open_float)

vim.keymap.set("n", "<c-l>dh", vim.diagnostic.hide)
vim.keymap.set("n", "<c-l>ds", vim.diagnostic.show)
vim.keymap.set("n", "<c-l>dr", vim.diagnostic.reset)
vim.keymap.set("n", "<c-l>dt", function()
   vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end)

-- --------------------------------------------------------------------------------
-- Treesitter
-- --------------------------------------------------------------------------------

M.build_textobject_keymaps = function()
   return {
      ["af"] = "@function.outer",
      ["if"] = "@function.inner",
      ["ac"] = "@class.outer",
      ["ic"] = "@class.inner",
      ["ai"] = "@conditional.outer",
      ["ii"] = "@conditional.inner",
      ["aa"] = "@attribute.outer",
      ["ia"] = "@attribute.inner",
      ["i;"] = "@statement.outer",
      ["a;"] = "@statement.outer",
   }
end

-- --------------------------------------------------------------------------------
-- LSP
-- --------------------------------------------------------------------------------
-- Docs:
--  - https://github.com/neovim/nvim-lspconfig
--  - https://neovim.io/doc/user/lsp.html
-- UI customizations: https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization
-- --------------------------------------------------------------------------------
M.set_common_lsp_keymaps = function(_, bufnr)
   local buf_opts = { noremap = true, silent = true, buffer = bufnr }

   -- Defaults as of nvim 0.10:
   vim.keymap.set("n", "K", vim.lsp.buf.hover, buf_opts)

   vim.keymap.set("n", "gd", function() require("telescope.builtin").lsp_definitions({ reuse_win = true }) end, buf_opts)
   vim.keymap.set("n", "gD", vim.lsp.buf.declaration, buf_opts)
   vim.keymap.set("n", "gt", function()
      require("telescope.builtin").lsp_type_definitions({ reuse_win = true })
   end, buf_opts)
   vim.keymap.set("n", "gi", function()
      require("telescope.builtin").lsp_implementations({ reuse_win = true })
   end, buf_opts)
   vim.keymap.set("n", "gK", vim.lsp.buf.signature_help, buf_opts)
   vim.keymap.set("i", "<c-k>", vim.lsp.buf.signature_help, buf_opts)
   vim.keymap.set("n", "<leader>k", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
   end, buf_opts)
   vim.keymap.set("i", "<m-k>", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
   end, buf_opts)

   -- LSP and orthogonal stuff. Also see more <c-l> chords in telescope config.
   vim.keymap.set("n", "<c-l>r", vim.lsp.buf.rename, buf_opts)
   vim.keymap.set("n", "<c-l>f", vim.lsp.buf.format, buf_opts)
   vim.keymap.set("n", "<c-l>a", vim.lsp.buf.code_action, buf_opts)
   vim.keymap.set("n", "<c-l>l", vim.lsp.codelens.run, buf_opts)
   vim.keymap.set("n", "<c-l>L", vim.lsp.codelens.refresh, buf_opts)
   vim.keymap.set("n", "<c-l>wa", vim.lsp.buf.add_workspace_folder, buf_opts)
   vim.keymap.set("n", "<c-l>wr", vim.lsp.buf.remove_workspace_folder, buf_opts)
   vim.keymap.set("n", "<c-l>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
   end, buf_opts)
end

-- --------------------------------------------------------------------------------
-- nvim cmp
-- --------------------------------------------------------------------------------
-- Docs: https://github.com/hrsh7th/nvim-cmp
-- --------------------------------------------------------------------------------
M.build_nvim_cmp_config_keymaps = function()
   local cmp = require("cmp")
   local luasnip = require("luasnip")

   return {
      ["<c-j>"] = cmp.mapping.select_next_item(),
      ["<c-k>"] = cmp.mapping.select_prev_item(),
      ["<c-space>"] = cmp.mapping.complete(),
      ["<c-e>"] = cmp.mapping(function(fallback)
         if luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
         else
            fallback()
         end
      end, { "i", "s" }),
      ["<c-b>"] = cmp.mapping(function(fallback)
         if luasnip.get_active_snip() and luasnip.jumpable(-1) then
            luasnip.jump(-1)
         else
            fallback()
         end
      end, { "i", "s" }),
      ["<c-n>"] = cmp.mapping(function(fallback)
         if luasnip.choice_active() then
            luasnip.change_choice(1)
         else
            fallback()
         end
      end, { "i", "s" }),
      ["<c-p>"] = cmp.mapping(function(fallback)
         if luasnip.choice_active() then
            luasnip.change_choice(-1)
         else
            fallback()
         end
      end, { "i", "s" }),
   }
end

-- --------------------------------------------------------------------------------
-- Telescope
-- --------------------------------------------------------------------------------
-- Default mappings: https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/mappings.lua
-- Actions: https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/actions/init.lua
-- --------------------------------------------------------------------------------

M.set_telescope_keymaps = function()
   local tsbuiltin = require("telescope.builtin")
   local tspimped = require("tspimped")

   vim.keymap.set("n", "<c-p>", tspimped.find_files)
   vim.keymap.set("i", "<c-p>", tspimped.find_files)
   vim.keymap.set("n", "<c-o>", tspimped.find_buffers)
   vim.keymap.set("n", "<c-t>/", tspimped.live_grep)

   vim.keymap.set("n", "<c-t>h", tsbuiltin.help_tags)
   vim.keymap.set("n", "<c-t>vm", tsbuiltin.keymaps)
   vim.keymap.set("n", "<c-t>vc", tsbuiltin.commands)
   vim.keymap.set("n", "<c-t>vr", tsbuiltin.reloader)
   vim.keymap.set("n", "<c-t>f", tsbuiltin.current_buffer_fuzzy_find)
   vim.keymap.set("n", "<c-t>*", tsbuiltin.grep_string)

   -- context:lang
   vim.keymap.set("n", "<c-l>dl", tsbuiltin.diagnostics)
   vim.keymap.set("n", "<c-l>ci", tsbuiltin.lsp_incoming_calls)
   vim.keymap.set("n", "<c-l>co", tsbuiltin.lsp_outgoing_calls)
   vim.keymap.set("n", "<c-l>tr", tsbuiltin.lsp_references)
   vim.keymap.set("n", "<c-l>ts", tsbuiltin.lsp_document_symbols)
   vim.keymap.set("n", "<c-l>tws", tsbuiltin.lsp_workspace_symbols)
   vim.keymap.set("n", "<c-l>tt", tsbuiltin.treesitter)

   -- context:git
   vim.keymap.set("n", "<c-g>s", tsbuiltin.git_status)
   vim.keymap.set("n", "<c-g>h", tsbuiltin.git_commits)
   vim.keymap.set("n", "<c-g>bh", tsbuiltin.git_bcommits)
   vim.keymap.set("n", "<c-g>f", tsbuiltin.git_files)
   vim.keymap.set("n", "<c-g>br", tsbuiltin.git_branches)
   vim.keymap.set("n", "<c-g>a", tsbuiltin.git_stash)
end

M.build_telescope_config_keymaps = function()
   local actions = require("telescope.actions")

   return {
      i = {
         ["<c-j>"] = actions.move_selection_next,
         ["<c-k>"] = actions.move_selection_previous,
      },
   }
end

-- --------------------------------------------------------------------------------
-- neo-tree
-- --------------------------------------------------------------------------------

vim.keymap.set("n", "<c-h>", "<cmd>Neotree toggle position=left reveal<cr>")
vim.keymap.set("n", "<c-m-h>", "<cmd>Neotree toggle position=float reveal<cr>")

M.build_neo_tree_config_keymaps = function()
   return {
      ["o"] = "toggle_node",
      ["O"] = "expand_all_nodes",
      ["<c-v>"] = "open_vsplit",
      ["<c-x>"] = "open_split",
      ["<c-t>"] = "open_tabnew",
   }
end

-- --------------------------------------------------------------------------------
-- aerial.nvim
-- --------------------------------------------------------------------------------

-- vim.keymap.set("n", "<c-m>", "<cmd>AerialToggle float<cr>")
vim.keymap.set("n", "<c-m-o>", function()
   -- NOTE: Workaround for https://github.com/stevearc/aerial.nvim/issues/331
   -- require('aerial').refetch_symbols()
   vim.cmd.AerialToggle 'float'
   vim.cmd.doautocmd 'BufWinEnter'
end)

vim.keymap.set("n", "<c-s-o>", "<cmd>AerialToggle<cr>")

M.build_aerial_config_keymaps = function()
   return {
      ["<esc>"] = "actions.close",
      -- Defaults
      ["?"] = "actions.show_help",
      ["g?"] = "actions.show_help",
      ["<CR>"] = "actions.jump",
      ["<2-LeftMouse>"] = "actions.jump",
      ["<c-v>"] = "actions.jump_vsplit",
      ["<c-s>"] = "actions.jump_split",
      ["p"] = "actions.scroll",
      ["<c-j>"] = "actions.down_and_scroll",
      ["<c-k>"] = "actions.up_and_scroll",
      ["{"] = "actions.prev",
      ["}"] = "actions.next",
      ["[["] = "actions.prev_up",
      ["]]"] = "actions.next_up",
      ["o"] = "actions.tree_toggle",
      ["za"] = "actions.tree_toggle",
      ["O"] = "actions.tree_toggle_recursive",
      ["zA"] = "actions.tree_toggle_recursive",
      ["l"] = "actions.tree_open",
      ["zo"] = "actions.tree_open",
      ["L"] = "actions.tree_open_recursive",
      ["zO"] = "actions.tree_open_recursive",
      ["h"] = "actions.tree_close",
      ["zc"] = "actions.tree_close",
      ["H"] = "actions.tree_close_recursive",
      ["zC"] = "actions.tree_close_recursive",
      ["zr"] = "actions.tree_increase_fold_level",
      ["zR"] = "actions.tree_open_all",
      ["zm"] = "actions.tree_decrease_fold_level",
      ["zM"] = "actions.tree_close_all",
      ["zx"] = "actions.tree_sync_folds",
      ["zX"] = "actions.tree_sync_folds",
   }
end

-- --------------------------------------------------------------------------------
-- leap.nvim
-- --------------------------------------------------------------------------------

M.set_leap_keymaps = function()
   local leap = require("leap")
   vim.keymap.set("n", "s", function()
      leap.leap({ target_windows = { vim.fn.win_getid() } })
   end)
end


-- --------------------------------------------------------------------------------
-- trailblazer.nvim
-- https://github.com/LeonHeidelbach/trailblazer.nvim?tab=readme-ov-file#%EF%B8%8F-configuration
-- --------------------------------------------------------------------------------

M.build_trailblazer_keymaps = function()
   return {
      nv = {
         motions = {
            new_trail_mark = '<c-m><c-m>',
            peek_move_next_down = '<c-j>',
            peek_move_previous_up = '<c-k>',
            track_back = '<c-m><c-b>',
            move_to_nearest = '<c-m>n',
            toggle_trail_mark_list = '<c-m>l',
         },
         actions = {
            delete_all_trail_marks = '<c-m>d',
            set_trail_mark_select_mode = '<c-m>s',
            switch_to_next_trail_mark_stack = '<c-m><c-l>',
            switch_to_previous_trail_mark_stack = '<c-m><c-h>',
            set_trail_mark_stack_sort_mode = '<c-m><s-s>',
         },
      }
   }
end


-- --------------------------------------------------------------------------------
-- resession.vim
-- --------------------------------------------------------------------------------

M.set_resession_keymaps = function()
   local resession = require("resession")
   local subsessions = require("subsessions")

   -- per-directory subsessions
   vim.keymap.set("n", "<leader>ss", subsessions.save_subsession)
   vim.keymap.set("n", "<leader>su", subsessions.update_subsession)
   vim.keymap.set("n", "<leader>sl", subsessions.load_subsession)
   vim.keymap.set("n", "<leader>sd", subsessions.delete_subsession)

   -- global sessions
   vim.keymap.set("n", "<leader>sgs", resession.save)
   vim.keymap.set("n", "<leader>sgl", resession.load)
   vim.keymap.set("n", "<leader>sgd", resession.delete)
end


-- --------------------------------------------------------------------------------
-- emmet.vim
-- --------------------------------------------------------------------------------

M.set_emmet_keymaps = function()
   vim.keymap.set("i", "<c-l>", "<plug>(emmet-expand-abbr)")
end


-- --------------------------------------------------------------------------------
-- bullets.vim
-- --------------------------------------------------------------------------------

M.set_bullets_keymaps = function()
   -- Note that there are other default key mappings at play in this plugin.

   -- Temp solution to add support for ensuring `O` also creates a new list item.
   vim.cmd([[
    function! SmartBulletsNewlineAbove()
        let l:save_cursor = getcurpos()
        let l:current_line_num = l:save_cursor[1]
        execute "normal! \<Plug>(bullets-newline)"
        if line('.') > l:current_line_num
            execute line('.') . 'move ' . (l:current_line_num - 1)
        endif
        execute "normal! \<Plug>(bullets-renumber)"
        call setpos('.', [0, l:current_line_num, 0, 0])
        call feedkeys('A', 'n')
    endfunction

    let g:bullets_custom_mappings = [
      \ ['nmap', 'O', ':call SmartBulletsNewlineAbove()<CR>'],
    \ ]
    ]])
end


-- --------------------------------------------------------------------------------
-- obsidian.vim
-- --------------------------------------------------------------------------------

M.set_obsidian_keymaps = function()
   vim.keymap.set("n", "<c-n>n", "<cmd>ObsidianNew<cr>")
   vim.keymap.set("n", "<c-n><c-n>", "<cmd>ObsidianNew<cr>")
   vim.keymap.set("n", "go", "<cmd>ObsidianFollowLink<cr>")
   vim.keymap.set("n", "gv", "<cmd>ObsidianFollowLink vsplit<cr>")
   vim.keymap.set("n", "gx", "<cmd>ObsidianFollowLink hsplit<cr>")
   vim.keymap.set("n", "<c-n>dt", "<cmd>ObsidianToday<cr>")
end


-- --------------------------------------------------------------------------------
-- Personal utils
-- --------------------------------------------------------------------------------

-- Cycle through options for bullet list items/cboxes.
vim.keymap.set("n", "<c-space>", function()
   require("pkm.bullets").cycle_cbox()
end)
vim.keymap.set("n", "<c-m-space>", function()
   require("pkm.bullets").remove_cbox()
end)

vim.keymap.set("n", "<c-n>i", function()
   require("pkm").open_index()
end)
vim.keymap.set("n", "gni", function()
   require("pkm").open_index()
end)
vim.keymap.set("n", "<c-n>1", function()
   require("pkm.utils").open_file_if_exists("lit/index.md")
end)
vim.keymap.set("n", "<c-n>2", function()
   require("pkm.utils").open_file_if_exists("zk/index.md")
end)
vim.keymap.set("n", "<c-n>3", function()
   require("pkm.utils").open_file_if_exists("self/index.md")
end)

vim.keymap.set("n", "<c-n>t", function()
   require("pkm").open_gtd()
end)
vim.keymap.set("n", "gnt", function()
   require("pkm").open_gtd()
end)

vim.keymap.set("n", "<c-n>dg", function()
   require("pkm").generate_diary_index()
end)
vim.keymap.set("n", "<c-s-j>", function()
   require("pkm").open_diary_relative(-1)
end)
vim.keymap.set("n", "<c-s-k>", function()
   require("pkm").open_diary_relative(1)
end)


-- --------------------------------------------------------------------------------

return M
