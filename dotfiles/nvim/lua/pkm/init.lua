local tsbuiltin = require("telescope.builtin")
local tspickers = require("telescope.pickers")
local tsfinders = require("telescope.finders")
local tsactions = require("telescope.actions")
local tsaction_state = require("telescope.actions.state")
local tsmake_entry = require("telescope.make_entry")
local tssorters = require("telescope.sorters")
local tsconf = require("telescope.config").values

local pkm_utils = require("pkm.utils")

local M = {}

local notes_dirs = {
   vim.env["_F"],
}
local notes_dirs_prefixes = {
   z = "zk/",
   n = "notes/",
   l = "lit/",
   m = "medi/",
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


--- Parses the telescope search prompt so when it gets prefixed with certain modifiers
--- (eg. /z), then only corresponding subdirectories are searched.
local function parse_search_prompt(prompt)
  local key, term = prompt:match("^/(%a) (.*)$")
  if key and notes_dirs_prefixes[key] then
    return term, notes_dirs_prefixes[key]
  end
  return prompt, nil
end

--- Custom sorter handles our prefix-capable prompts. Without this, search results can
--- get messed up as the prefix is used for scoring and items may get dropped.
local function make_sorter()
   local sorter = tsconf.file_sorter(opts)

   local score = sorter.scoring_function
   sorter.scoring_function = function(self, prompt, line, ...)
      local term = parse_search_prompt(prompt)
      return score(self, term, line, ...)
   end

   local highlight = sorter.highlighter
   if highlight then
      sorter.highlighter = function(self, prompt, display)
         local term = parse_search_prompt(prompt)
         return highlight(self, term, display)
      end
   end

   sorter.discard = false -- don't reuse results filtered on a partial "/z" prompt
   return sorter
end
local sorter = make_sorter()

-- --------------------------------------------------------------------------------


M.live_grep_notes = function(opts)
   opts = vim.tbl_extend("force", note_picker_opts, opts or {})
   opts.cwd = opts.cwd or vim.uv.cwd()

   local finder = tsfinders.new_job(function(prompt)
      local term, dir = parse_search_prompt(prompt)
      if not term or term == "" then
         return nil
      end

      local cmd = vim.list_extend({}, tsconf.vimgrep_arguments)
      if opts.additional_args then
         local extra = type(opts.additional_args) == "function"
             and opts.additional_args(opts)
             or opts.additional_args
         vim.list_extend(cmd, extra)
      end
      vim.list_extend(cmd, { "--", term })
      table.insert(cmd, dir or ".")
      return cmd
   end, tsmake_entry.gen_from_vimgrep(opts), opts.max_results, opts.cwd)

   local sorter = tssorters.highlighter_only(opts)
   local highlight = sorter.highlighter
   sorter.highlighter = function(self, prompt, display)
      local term = parse_search_prompt(prompt)
      return highlight(self, term, display)
   end

   tspickers
       .new(opts, {
          prompt_title = "Live Grep Notes",
          finder = finder,
          previewer = tsconf.grep_previewer(opts),
          sorter = sorter,
       })
       :find()
end


M.find_notes = function(opts)
   opts = vim.tbl_extend("force", note_picker_opts, opts or {})

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

   local finder = tsfinders.new_job(function(prompt)
      local term, dir = parse_search_prompt(prompt)
      local cmd = { "rg", "-m", "1", "-r", "$title_text", "^# (?P<title_text>)"}
      if dir then table.insert(cmd, dir) end
      return cmd
   end, make_entry, opts.max_results, opts.cwd)

   tspickers
       .new(opts, {
          prompt_title = "Note Files",
          finder = finder,
          sorter = sorter,
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
      end
   end

   local lines = { "# Index - Diary", "" }
   for y, mdata in pkm_utils.pairs_by_keys(data, function(a, b) return a > b end) do
      table.insert(lines, "## " .. y)
      table.insert(lines, "")
      for m, ddata in pkm_utils.pairs_by_keys(mdata, function(a, b) return a > b end) do
         table.insert(lines, "### " .. os.date("%B", os.time({ month = tonumber(m), day = 1, year = 1 })))
         table.insert(lines, "")
         for d, dinfo in pkm_utils.pairs_by_keys(ddata, function(a, b) return a > b end) do
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

-- Generate index file contents from all files in the current file's directory.
M.generate_index = function()
   local curr_path = vim.api.nvim_buf_get_name(0);
   local curr_path_dir = vim.fs.normalize(vim.fs.joinpath(curr_path, ".."))

   local lines = {"# Index - ZK", ""}

   for _, note_path in ipairs(pkm_utils.scan_files_recursive(curr_path_dir)) do
      if note_path == "index.md" then
         goto continue
      end

      local title = pkm_utils.get_h1_from_path(nil, curr_path_dir .. "/" .. note_path)
      table.insert(lines, string.format("- [[%s|%s]]", note_path, title))

      ::continue::
   end

   vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
end

M.open_diary_relative = function(n)
   local diary_entries = {}
   for _, item in ipairs(pkm_utils.scan_dir("diary")) do
      local d = string.match(item.name, "^(%d%d%d%d%-%d%d%-%d%d)%.md")
      if d ~= nil then
         table.insert(diary_entries, { name = item.name, ts = pkm_utils.to_timestamp(d) })
      end
   end
   table.sort(diary_entries, function(a, b) return a.ts < b.ts end)

   local bname = vim.fs.basename(vim.api.nvim_buf_get_name(0))
   for i, entry in ipairs(diary_entries) do
      if entry.name == bname then
         local j = i + n
         if j > 0 and j <= #diary_entries then
            vim.cmd("edit diary/" .. diary_entries[j].name)
            return
         end
      end
   end
end

return M
