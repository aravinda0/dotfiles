local telescope_builtin = require("telescope.builtin")
local telescope_pickers = require("telescope.pickers")
local telescope_finders = require("telescope.finders")
local telescope_conf = require("telescope.config").values

local M = {}

local notes_dirs = {
  vim.env["FORGE"],
}

local get_h1_from_path = function(_, path)
  local file_to_h1_cache = {}

  local cache_hit = file_to_h1_cache[path]
  if cache_hit ~= nil then
    return cache_hit
  end

  -- Open file and only look at the first line. That's where we expect the h1 to be
  -- which starts with '# '.
  for line in io.lines(path) do
    local h1 = string.sub(line, 3)
    file_to_h1_cache[path] = h1
    return h1
  end
end

local h1_picker_opts = {
  path_display = get_h1_from_path,

  -- The default layout gives slight preference to the preview window. It's a bit too
  -- wasteful since we use sensible line-lengths.
  horizontal = { preview_width = 0.5 },
}

M.live_grep_notes = function(opts)
  opts = vim.tbl_extend("force", h1_picker_opts, opts or {})
  telescope_builtin.live_grep(opts)
end

M.find_notes = function(opts)
  opts = vim.tbl_extend("force", h1_picker_opts, opts or {})

  local find_cmd = { "rg", "-m", "1", "-r", "$title_text", "^# (?P<title_text>)" }

  local make_entry = function(raw_value)
    local split = vim.split(raw_value, ":")
    local rel_path = split[1]
    local abs_path = vim.fn.getcwd() .. "/" .. rel_path
    local title = split[2]

    return {
      value = raw_value,
      display = title,
      ordinal = raw_value,
      path = abs_path,
    }
  end

  telescope_pickers
    .new(opts, {
      prompt_title = "Note Files",
      finder = telescope_finders.new_oneshot_job(
        find_cmd,
        { entry_maker = make_entry }
      ),
      sorter = telescope_conf.file_sorter(opts),
      previewer = telescope_conf.file_previewer(opts),
    })
    :find()
end

M.find_notes_buffers = function(opts)
  local local_opts = {
    horizontal = h1_picker_opts.horizontal,
  }
  opts = vim.tbl_extend("force", local_opts, opts or {})

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

  local display_entry = function(entry)
    local h1 = vim.api.nvim_buf_get_lines(entry.value.bufnr, 0, 1, false)[1]
    if h1 then
      return string.sub(h1, 3)
    else
      return entry.path
    end
  end

  local make_entry = function(raw_value)
    return {
      value = raw_value,
      display = display_entry,

      -- NOTE: Copied from Telescope code. Not sure how this ordinal here is tied to
      -- the above sort, but it seems to work.
      ordinal = raw_value.bufnr .. ":" .. raw_value.info.name,

      path = raw_value.info.name,
    }
  end

  telescope_pickers
    .new(opts, {
      prompt_title = "Note Buffers",
      finder = telescope_finders.new_table({
        results = buffers,
        entry_maker = make_entry,
      }),
      previewer = telescope_conf.grep_previewer(opts),
      sorter = telescope_conf.generic_sorter(opts),
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

return M
