local tsbuiltin = require("telescope.builtin")

local pkm = require("pkm")

local M = {}

M.find_files = function()
   if pkm.is_cwd_notes_dir() then
      pkm.find_notes()
   else
      tsbuiltin.find_files()
   end
end

M.find_buffers = function()
   local opts = {
      ignore_current_buffer = true,
      sort_mru = true,
   }

   if pkm.is_cwd_notes_dir() then
      pkm.find_notes_buffers(opts)
   else
      tsbuiltin.buffers(opts)
   end
end

M.live_grep = function()
   if pkm.is_cwd_notes_dir() then
      pkm.live_grep_notes()
   else
      tsbuiltin.live_grep()
   end
end

return M
