local M = {}


M.setup = function()
  require("session_manager").setup({
    sessions_dir = vim.fn.stdpath('data') .. '/sessions',
    path_replacer = '__',
    colon_replacer = '++',
    autoload_mode = require('session_manager.config').AutoloadMode.CurrentDir,
    autosave_last_session = true,
    autosave_ignore_not_normal = true,
    autosave_ignore_dirs = {
      vim.env["MY_NOTES_PATH"] .. "/notes",
      vim.env["HOME"],
      vim.env["HOME"] .. "/Downloads",
      "/tmp",
    },
    autosave_ignore_filetypes = {
      'gitcommit',
    },
    autosave_ignore_buftypes = {},

    -- Always autosaves session. If true, only autosaves after a session is active.
    autosave_only_in_session = false,
  })
end


return M
