local M = {}


local _cycle_cbox = function(line)
   local c_bullet, c_post_bullet = string.match(line, "^(%s*[-*+] )(.*)")

   if c_bullet == nil then
      -- Turn the line into a cbox while preserving any leading whitespace.
      return string.gsub(line, "^%s*", "%1* [ ] ")
   end

   -- If already a list, but not a cbox => turn into cbox.
   if string.match(c_post_bullet, "%[[%s.oOxX%-]%]") == nil then
      return string.format(c_bullet .. "[ ] " .. c_post_bullet)
   end

   -- For cboxes, toggle/cycle markers.
   local modded_post_bullet = string.gsub(c_post_bullet, "^%[([%s.oOxX%-])%]", function(c_marker)
      if c_marker == "X" then
         return "[ ]"
      else
         return "[X]"
      end
   end)

   return c_bullet .. modded_post_bullet
end

local _remove_cbox = function(line)
   local p_cbox_item = "^(%s*[-*+]) %[[%s.oOxX%-]%]"
   local modded_line, _ = string.gsub(line, p_cbox_item, function(c_bullet)
      return c_bullet
   end)
   return modded_line
end

M.cycle_cbox = function()
   local line = vim.api.nvim_get_current_line()
   vim.api.nvim_set_current_line(_cycle_cbox(line))
end

M.remove_cbox = function()
   local line = vim.api.nvim_get_current_line()
   vim.api.nvim_set_current_line(_remove_cbox(line))
end


return M
