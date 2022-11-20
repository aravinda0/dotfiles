local builtin = require("telescope.builtin")

local M = {}


M.live_grep_notes = function(opts)
  local local_opts = {}

  local file_to_h1_cache = {}
  local_opts.path_display = function(_, path)
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

  -- The default layout gives slight preference to the preview window. It's a bit too
  -- wasteful since we use sensible line-lengths.
  local_opts.layout_config = {
    horizontal = { preview_width = 0.5 }
  }

  opts = vim.tbl_extend("force", local_opts, opts or {})
  builtin.live_grep(opts)
end


M.contextual_live_grep = function(opts)
  local notes_dirs = {
    vim.env["MY_NOTES_PATH"],
  }
  local cwd = vim.fn.getcwd()

  for _, notes_dir in pairs(notes_dirs) do
    if string.match(cwd, vim.fs.normalize(notes_dir)) then
      M.live_grep_notes(opts)
      return
    end
  end

  builtin.live_grep(opts)
end


return M
