local tsbuiltin = require("telescope.builtin")
local tsactions = require("telescope.actions")
local tsaction_state = require("telescope.actions.state")

local M = {}


--- Open a standard telescope picker, show results of `find_cmd` as options. Once
--- something is selected, `handler` is invoked on the item's path.
M.find_item_and_act = function(find_cmd, handler, cwd)
   local handle_selection = function(prompt_bufnr, map)
      tsactions.select_default:replace(function()
         tsactions.close(prompt_bufnr)
         local selection = tsaction_state.get_selected_entry()[1]
         handler(selection)
      end)
      return true
   end

   local opts = {
      cwd = cwd,
      find_command = find_cmd,
      attach_mappings = handle_selection,
   }
   tsbuiltin.find_files(opts)
end


return M
