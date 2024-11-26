local tsbuiltin = require("telescope.builtin")
local tspickers = require("telescope.pickers")
local tsfinders = require("telescope.finders")
local tsactions = require("telescope.actions")
local tsaction_state = require("telescope.actions.state")
local tsconf = require("telescope.config").values

local pkm_utils = require("pkm.utils")

local M = {}

local notes_dirs = {
   vim.env["_F"],
}

local handle_picker_mappings = function(prompt_bufnr, map)
   local insert_link = function()
      local selection = tsaction_state.get_selected_entry()
      tsactions.close(prompt_bufnr)
      local notes_path = pkm_utils.to_notes_path(selection.path)
      pkm_utils.insert_link(selection.display, notes_path)
   end

   map("i", "<c-l>", insert_link)

   -- Default to inserting note links when in insert mode
   if vim.fn.mode() == "i" then
      tsactions.select_default:replace(insert_link)
   end

   return true
end

local common_picker_opts = {
   attach_mappings = handle_picker_mappings,

   -- The default layout gives slight preference to the preview window. It's a bit too
   -- wasteful since we use sensible line-lengths.
   horizontal = { preview_width = 0.5 },
}
local note_picker_opts = vim.tbl_extend("force", common_picker_opts, {
   path_display = pkm_utils.get_h1_from_path,
})

-- --------------------------------------------------------------------------------

M.live_grep_notes = function(opts)
   opts = vim.tbl_extend("force", note_picker_opts, opts or {})
   tsbuiltin.live_grep(opts)
end

M.find_notes = function(opts)
   opts = vim.tbl_extend("force", note_picker_opts, opts or {})

   local find_cmd = { "rg", "-m", "1", "-r", "$title_text", "^# (?P<title_text>)" }

   local make_entry = function(raw_value)
      local i_colon = string.find(raw_value, ":")
      local rel_path = string.sub(raw_value, 1, i_colon - 1)
      local title = string.sub(raw_value, i_colon + 1)
      local abs_path = vim.fn.getcwd() .. "/" .. rel_path

      return {
         value = raw_value,
         display = title,
         ordinal = raw_value,
         rel_path = rel_path,
         path = abs_path,
      }
   end

   tspickers
       .new(opts, {
          prompt_title = "Note Files",
          finder = tsfinders.new_oneshot_job(find_cmd, { entry_maker = make_entry }),
          sorter = tsconf.file_sorter(opts),
          previewer = tsconf.file_previewer(opts),
       })
       :find()
end

M.find_notes_buffers = function(opts)
   opts = vim.tbl_extend("force", common_picker_opts, opts or {})

   local bufnrs = vim.tbl_filter(function(b)
      if vim.fn.buflisted(b) ~= 1 then
         return false
      end
      if opts.show_all_buffers == false and not vim.api.nvim_buf_is_loaded(b) then
         return false
      end
      if opts.ignore_current_buffer and b == vim.api.nvim_get_current_buf() then
         return false
      end
      if
          opts.cwd_only
          and not string.find(vim.api.nvim_buf_get_name(b), vim.loop.cwd(), 1, true)
      then
         return false
      end
      return true
   end, vim.api.nvim_list_bufs())

   if not next(bufnrs) then
      return
   end

   if opts.sort_mru then
      table.sort(bufnrs, function(a, b)
         return vim.fn.getbufinfo(a)[1].lastused > vim.fn.getbufinfo(b)[1].lastused
      end)
   end

   local buffers = {}
   for _, bufnr in ipairs(bufnrs) do
      table.insert(buffers, {
         bufnr = bufnr,
         info = vim.fn.getbufinfo(bufnr)[1],
      })
   end

   local make_entry = function(raw_value)
      local h1 = vim.api.nvim_buf_get_lines(raw_value.bufnr, 0, 1, false)[1]
      local path = raw_value.info.name
      local display

      if h1 then
         display = string.sub(h1, 3)
      else
         display = path
      end

      return {
         value = raw_value,
         display = display,
         ordinal = display,
         path = path,
      }
   end

   tspickers
       .new(opts, {
          prompt_title = "Note Buffers",
          finder = tsfinders.new_table({
             results = buffers,
             entry_maker = make_entry,
          }),
          previewer = tsconf.grep_previewer(opts),
          sorter = tsconf.generic_sorter(opts),
       })
       :find()
end

M.is_cwd_notes_dir = function()
   local cwd = vim.fn.getcwd()

   for _, notes_dir in pairs(notes_dirs) do
      if string.match(cwd, vim.fs.normalize(notes_dir)) then
         return true
      end
   end

   return false
end

M.open_index = function()
   pkm_utils.open_file_if_exists({ "index.md", "diary/diary.md" })
end

M.open_gtd = function()
   pkm_utils.open_file_if_exists({ "gtd.md", "tasks/index.md" })
end

M.generate_diary_index = function()
   local data = {}

   -- Group data by Y/M/D.
   for _, item in ipairs(pkm_utils.scan_dir("diary")) do
      local y, m, d = string.match(item.name, "(%d%d%d%d)-(%d%d)-(%d%d)%.md")
      if y ~= nil then
         if data[y] == nil then
            data[y] = { [m] = {} }
         end
         if data[y][m] == nil then
            data[y][m] = {}
         end

         local timestamp = os.time({
            year = tonumber(y),
            month = tonumber(m),
            day = tonumber(d),
         })
         table.insert(data[y][m], { name = item.name, timestamp = timestamp })
         -- local pretty_date = os.date("%d %b %Y - %a", timestamp)
         -- table.insert(data[y][m], string.format("[[%s|%s]]", item.name, pretty_date))
      end
   end

   local lines = { "# Index - Diary", "" }
   for y, mdata in pkm_utils.pairsByKeys(data, function(a, b) return a > b end) do
      table.insert(lines, "## " .. y)
      table.insert(lines, "")
      for m, ddata in pkm_utils.pairsByKeys(mdata, function(a, b) return a > b end) do
         table.insert(lines, "### " .. os.date("%B", os.time({ month = tonumber(m), day = 1, year = 1 })))
         table.insert(lines, "")
         for d, dinfo in pkm_utils.pairsByKeys(ddata, function(a, b) return a > b end) do
            local pretty_date = os.date("%d %b %Y - %a", dinfo.timestamp)
            local line = string.format("- [[%s|%s]]", dinfo.name, pretty_date)
            table.insert(lines, line)
         end
         table.insert(lines, "")
      end
      table.insert(lines, "")
   end

   vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
end

return M
