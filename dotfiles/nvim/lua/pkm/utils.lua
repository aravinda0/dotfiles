local M = {}

M.get_h1_from_path = function(_, path)
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

M.insert_link = function(title, target)
   local link = string.format("[%s](%s)", title, target)
   vim.api.nvim_put({ link }, "", false, true)
end

M.to_notes_path = function(abs_path)
   local _H = vim.env["_H"]
   if not _H then
      error("$_H env var has not been set!")
   end

   local notes_path = abs_path

   if string.sub(abs_path, 1, string.len(_H)) == _H then
      notes_path = "$_H" .. string.sub(abs_path, string.len(_H) + 1)
   else
      -- fall back to providing path relative to cwd
      local cwd = vim.fn.getcwd()
      notes_path = string.sub(abs_path, string.len(cwd) + 2)
   end

   return notes_path
end

M.scan_dir = function(dir)
   local results = {}
   local handle = vim.uv.fs_scandir(dir)
   if handle then
      while true do
         local name, type = vim.uv.fs_scandir_next(handle)
         if not name then break end

         table.insert(results, {
            name = name,
            type = type,
         })
      end
   end
   return results
end

M.file_exists = function(path)
   local file = io.open(path, "r")
   if file then
      return true
   end
   return false
end

--- Opens a file to edit if it exists.
--- @param path string | table: A single path or a list of paths. The first existing
--- file will be opened.
M.open_file_if_exists = function(path)
   local paths
   if type(path) == "string" then
      paths = { path }
   else
      paths = path
   end

   for _, f in ipairs(paths) do
      if M.file_exists(f) then
         vim.cmd("edit " .. f)
         return
      end
   end
end

return M
