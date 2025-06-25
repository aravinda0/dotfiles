-- AI-generated code.
-- ----------------------------------------------------------------------------------------

local utils = require 'mp.utils'
local msg = require 'mp.msg'

-- Configuration constants
local MAX_FILES = 5000
local MAX_DEPTH = 10
local SCAN_TIMEOUT = 10 -- seconds

local supported_extensions = {
   "mp4", "mkv", "avi", "mov", "wmv", "flv", "webm", "m4v",
   "mp3", "flac", "wav", "ogg", "aac", "m4a", "wma"
}

-- Convert to set for faster lookup
local supported_ext_set = {}
for _, ext in ipairs(supported_extensions) do
   supported_ext_set[ext:lower()] = true
end

local function has_supported_extension(filename)
   if not filename or filename == "" then return false end
   local ext = filename:match("%.([^%.]+)$")
   if not ext then return false end
   return supported_ext_set[ext:lower()] == true
end

-- Secure path validation and sanitization
local function sanitize_and_validate_path(path)
   if not path or path == "" then
      return nil, "Empty path provided"
   end

   -- Remove dangerous characters that could be used for command injection
   if path:match("[;&|`$(){}\\<>]") then
      return nil, "Path contains invalid characters"
   end

   -- Prevent path traversal attacks
   if path:match("%.%.") then
      return nil, "Path traversal not allowed"
   end

   -- Normalize path separators and resolve
   local normalized = path:gsub("\\", "/"):gsub("//+", "/")

   -- Remove trailing slash except for root
   if normalized:len() > 1 and normalized:sub(-1) == "/" then
      normalized = normalized:sub(1, -2)
   end

   return normalized, nil
end

-- Check if directory access is allowed
local function is_safe_directory(path)
   if not path then return false end

   -- Get user's home directory safely
   local home = os.getenv("HOME") or os.getenv("USERPROFILE")
   if not home then
      msg.warn("Could not determine home directory")
      return false
   end

   -- Define allowed directory prefixes
   local safe_prefixes = {
      home .. "/Music",
      home .. "/Videos",
      home .. "/Documents",
      home .. "/Downloads",
      "/media/",
      "/mnt/",
      "/tmp/media/",
   }

   -- On Windows, add common media directories
   if os.getenv("OS") and os.getenv("OS"):match("Windows") then
      table.insert(safe_prefixes, "C:/Users/" .. (os.getenv("USERNAME") or "") .. "/Music")
      table.insert(safe_prefixes, "C:/Users/" .. (os.getenv("USERNAME") or "") .. "/Videos")
   end

   -- Check if path starts with any safe prefix
   for _, prefix in ipairs(safe_prefixes) do
      if path:sub(1, #prefix) == prefix then
         return true
      end
   end

   -- Allow current working directory and its subdirectories
   local cwd = mp.get_property("working-directory")
   if cwd and path:sub(1, #cwd) == cwd then
      return true
   end

   -- Allow directory of currently playing file
   local current_file = mp.get_property("path")
   if current_file then
      local current_dir = utils.split_path(current_file)
      if current_dir and path:sub(1, #current_dir) == current_dir then
         return true
      end
   end


   return false
end

-- Safe file system scanning without subprocess
local function scan_directory_safe(directory, max_files, max_depth, current_depth)
   current_depth = current_depth or 0
   max_files = max_files or MAX_FILES
   max_depth = max_depth or MAX_DEPTH

   if current_depth >= max_depth then
      return {}
   end

   local files = {}
   local file_count = 0

   -- Use readdir for safe directory listing
   local dir_content = utils.readdir(directory, "files")
   if not dir_content then
      return files
   end

   -- Process files first
   for _, item in ipairs(dir_content) do
      if file_count >= max_files then
         msg.warn("File limit reached (" .. max_files .. "), stopping scan")
         break
      end

      local full_path = utils.join_path(directory, item)
      if has_supported_extension(item) then
         table.insert(files, full_path)
         file_count = file_count + 1
      end
   end

   -- Then process subdirectories if we haven't hit limits
   if current_depth < max_depth and file_count < max_files then
      local subdirs = utils.readdir(directory, "dirs")
      if subdirs then
         for _, subdir in ipairs(subdirs) do
            if file_count >= max_files then break end

            -- Skip hidden directories and common non-media directories
            if not subdir:match("^%.") and
                not subdir:match("^__") and
                subdir ~= "System Volume Information" then
               local subdir_path = utils.join_path(directory, subdir)
               local subdir_files = scan_directory_safe(subdir_path, max_files - file_count, max_depth, current_depth + 1)

               for _, file in ipairs(subdir_files) do
                  if file_count >= max_files then break end
                  table.insert(files, file)
                  file_count = file_count + 1
               end
            end
         end
      end
   end

   return files
end

-- Main function to find media files with security controls
local function find_media_files(directory)
   local sanitized_dir, error_msg = sanitize_and_validate_path(directory)
   if not sanitized_dir then
      msg.error("Invalid directory path: " .. (error_msg or "unknown error"))
      return {}
   end

   if not is_safe_directory(sanitized_dir) then
      msg.error("Access denied to directory: " .. sanitized_dir)
      return {}
   end

   -- Check if directory exists and is readable
   local dir_content = utils.readdir(sanitized_dir)
   if not dir_content then
      msg.error("Cannot read directory: " .. sanitized_dir)
      return {}
   end

   msg.info("Scanning directory: " .. sanitized_dir)
   local start_time = os.time()
   local files = scan_directory_safe(sanitized_dir, MAX_FILES, MAX_DEPTH)
   local scan_time = os.time() - start_time

   if scan_time > SCAN_TIMEOUT then
      msg.warn("Directory scan took " .. scan_time .. " seconds")
   end

   msg.info("Found " .. #files .. " media files")
   return files
end

-- Secure random number generation
local function get_secure_random(max)
   if max <= 0 then return 1 end

   -- Use current time with microseconds for better randomness
   local seed = os.time() + (os.clock() * 1000000) % 1000000
   math.randomseed(seed)

   -- Generate multiple random numbers to improve distribution
   for i = 1, 3 do
      math.random()
   end

   return math.random(1, max)
end

-- Function to play random file from current directory
local function play_random_file()
   local current_file = mp.get_property("path")
   if not current_file then
      msg.warn("No file currently playing")
      return
   end

   local directory = utils.split_path(current_file)
   if not directory then
      msg.error("Could not determine current directory")
      return
   end

   local media_files = find_media_files(directory)
   if #media_files == 0 then
      msg.warn("No media files found in current directory")
      return
   end

   local random_index = get_secure_random(#media_files)
   local selected_file = media_files[random_index]

   msg.info("Playing random file: " .. utils.split_path(selected_file))
   mp.commandv("loadfile", selected_file)
end

-- Function to play random file from working directory
local function play_random_from_cwd()
   local directory = mp.get_property("working-directory")
   if not directory then
      msg.error("Could not determine working directory")
      return
   end

   local media_files = find_media_files(directory)
   if #media_files == 0 then
      msg.warn("No media files found in working directory")
      return
   end

   local random_index = get_secure_random(#media_files)
   local selected_file = media_files[random_index]

   msg.info("Playing random file: " .. utils.split_path(selected_file))
   mp.commandv("loadfile", selected_file)
end

-- Secure handler for external path requests
local function play_random_from_path(path)
   if not path or path == "" then
      msg.error("No path provided")
      return
   end

   -- Additional validation for external requests
   if #path > 500 then
      msg.error("Path too long")
      return
   end

   local media_files = find_media_files(path)
   if #media_files == 0 then
      msg.warn("No media files found in: " .. path)
      return
   end

   local random_index = get_secure_random(#media_files)
   local selected_file = media_files[random_index]

   msg.info("Playing random file: " .. utils.split_path(selected_file))
   mp.commandv("loadfile", selected_file)
end

-- Register secure script messages
-- mp.register_script_message("play-random", play_random_file)
-- mp.register_script_message("play-random-from", play_random_from_path)

-- Register key bindings
mp.add_key_binding("Ctrl+Up", "random-from-cwd", play_random_from_cwd)
mp.add_key_binding("Ctrl+Alt+Up", "random-file", play_random_file)
