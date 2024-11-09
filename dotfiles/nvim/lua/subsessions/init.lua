local resession = require("resession")
local resession_utils = require("resession.util")
local resession_files = require("resession.files")
local tspickers = require("telescope.pickers")
local tsfinders = require("telescope.finders")
local tsconf = require("telescope.config").values
local tsactions = require("telescope.actions")
local tsaction_state = require("telescope.actions.state")


local uv = vim.uv or vim.loop


local M = {}

local get_relative_subsession_dir = function()
   local dirsession_dir = "dirsession"
   local cwd_dirsession_name = vim.fn.getcwd():gsub(resession_files.sep, "_"):gsub(":", "_")
   return resession_files.join(dirsession_dir, cwd_dirsession_name)
end

---Show a telescope picker and provide a default selection action.
---@param items table A list of items that have at least a `label` key for display
---purposes.
local pick_item = function(items, on_select)
   tspickers.new({}, {
      prompt_title = "colors",
      finder = tsfinders.new_table {
         results = items,
         entry_maker = function(entry)
            return {
               value = entry,
               display = entry.label,
               ordinal = entry.label,
            }
         end,
      },
      sorter = tsconf.generic_sorter(),
      attach_mappings = function(prompt_bufnr, map)
         tsactions.select_default:replace(function()
            tsactions.close(prompt_bufnr)
            on_select(tsaction_state.get_selected_entry().value)
         end)
         return true
      end,
   }):find()
end


----Get subsession names.
---@return table A list of entries with `label` keys.
local get_subsession_names = function()
   local subsessions_dir = resession_utils.get_session_dir(get_relative_subsession_dir())
   if not resession_files.exists(subsessions_dir) then
      return {}
   end

   local fd = uv.fs_opendir(subsessions_dir, nil, 256)
   local entries = uv.fs_readdir(fd)
   local subsessions = {}

   for _, entry in ipairs(entries) do
      if entry.type == "file" then
         local name = entry.name:match("^(.+)%.json$")
         if name then
            table.insert(subsessions, {
               label = name,
            })
         end
      end
   end

   uv.fs_closedir(fd)

   return subsessions
end

M.save_subsession = function()
   local subsession_name = nil
   vim.ui.input({ prompt = "Session name: " }, function(selected)
      if selected then
         subsession_name = selected
      end
   end)

   resession.save(subsession_name, { dir = get_relative_subsession_dir() })
end

M.update_subsession = function(name)
   local subsessions = get_subsession_names()
   pick_item(subsessions, function(selected)
      resession.save(selected.label, { dir = get_relative_subsession_dir() })
   end)
end

M.load_subsession = function()
   local subsessions = get_subsession_names()
   pick_item(subsessions, function(selected)
      resession.load(selected.label, { dir = get_relative_subsession_dir() })
   end)
end

M.delete_subsession = function()
   local subsessions = get_subsession_names()
   pick_item(subsessions, function(selected)
      resession.delete(selected.label, { dir = get_relative_subsession_dir() })
   end)
end


return M
