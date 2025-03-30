local tsactions = require("telescope.actions")
local tsaction_state = require("telescope.actions.state")
local tsconf = require("telescope.config").values
local tspickers = require("telescope.pickers")
local tsfinders = require("telescope.finders")

local M = {}


---@class FindAndThenOpts
local default_find_and_then_opts = {
   src_cmd = nil,
   src_items = nil,
   cwd = nil, -- Only valid when `src_cmd` specified
   title = "Find Items",
}

--- Open a generic Telescope picker that can show results from a list or from a command.
--- The selected item then has `handler` invoked on it.
---
---@param opts FindAndThenOpts
---@param handler fun(selection: string)
M.find_and_then = function(opts, handler)
   opts = vim.tbl_extend("force", default_find_and_then_opts, opts)

   local finder
   if opts.src_cmd ~= nil then
      finder = tsfinders.new_oneshot_job(opts.src_cmd, { cwd = opts.cwd })
   else
      finder = tsfinders.new_table({
         results = opts.src_items
      })
   end

   local handle_selection = function(prompt_bufnr, _)
      tsactions.select_default:replace(function()
         tsactions.close(prompt_bufnr)
         local selection = tsaction_state.get_selected_entry()[1]
         handler(selection)
      end)
      return true
   end

   tspickers
       .new({}, {
          prompt_title = opts.title,
          finder = finder,
          sorter = tsconf.file_sorter({}),
          previewer = tsconf.file_previewer({}),
          attach_mappings = handle_selection,
       })
       :find()
end


return M
