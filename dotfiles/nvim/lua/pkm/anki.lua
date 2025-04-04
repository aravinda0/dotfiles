local pldir = require("pl.dir")
local plstr = require("pl.stringx")
local plpath = require("pl.path")

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

M.generate_cards_index = function()
   local lines = { "# Index - Cards", "" }
   for root, dirs, files in pldir.walk(ANKI_DIR) do
      local deck_name = plpath.relpath(root, ANKI_DIR)
      if deck_name == ""  or #files == 0 then
         goto continue
      end

      local heading = string.rep("#", plstr.count(deck_name, "/") + 2) .. " " .. deck_name
      table.insert(lines, heading)
      table.insert(lines, "")

      for i, f in ipairs(files) do
         if f == "+deck.json" or f == "index.md" then
            goto continue_2
         end
         local card_h = io.open(root .. "/" .. f, "r")
         if card_h then
            local card_contents = card_h:read("a*") 

            -- Dissect into a preview snippet of the question part.
            local q = plstr.split(card_contents, "## Question")[2]
            local q = plstr.split(q, "## Answer")[1]
            local q = plstr.fill(q, 90)
            local q = plstr.shorten(q, 90)
            local q = plstr.strip(q)

            table.insert(lines, "- [[" .. f .. "|" .. q .. "]]")

            card_h:close()
         end
         ::continue_2::
      end
      table.insert(lines, "")
      table.insert(lines, "")
      ::continue::
   end

   vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
end


return M
