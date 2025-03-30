local pkm_utils = require("pkm.utils")
local tsutils = require("pkm.tsutils")

local M = {}
local ANKI_DIR = vim.env["_Z"] .. "/anki"


--- Generates a new random anki-friendly ID number. Will ensure a card with the
--- generated ID doesn't already exist.
M.generate_anki_id = function()
   for _ = 1, 10 do
      local new_id = math.random(2 ^ 30, 2 ^ 31)
      local result = vim.system(
         { "fd", "-t", "f", "--base-directory", ANKI_DIR, string.format("%s.card.md", new_id) },
         { text = true }
      ):wait()
      if result.code == 0 and result.stdout == "" then
         return new_id
      end
   end

   error("Failed to generate anki ID!")
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
