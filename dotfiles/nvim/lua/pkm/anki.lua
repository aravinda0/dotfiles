local pkm_utils = require("pkm.utils")
local tsutils = require("pkm.tsutils")

local M = {}
local ANKI_DIR = vim.env["_Z"] .. "/anki"


M.generate_anki_id = function()
   -- TODO: 🚧 Inspect all existing cards, make sure not the same ID.
   return math.random(2 ^ 30, 2 ^ 31)
end


M.new_card = function()
   local handler = function(selection)
      local new_card_name = M.generate_anki_id() .. ".card.md"
      local new_card_path = ANKI_DIR .. "/" .. selection .. new_card_name
      if pkm_utils.file_exists(new_card_path) then
         return
      end

      vim.cmd("edit " .. new_card_path)
   end

   tsutils.find_and_then({ src_cmd = { "fd", "-t", "d" }, cwd = ANKI_DIR }, handler)
end


M.new_deck = function()
   -- TODO: 🚧 
end


return M
