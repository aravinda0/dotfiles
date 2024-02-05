return {
  {
    "stevearc/resession.nvim",
    opts = {},
    config = function()
      local resession = require("resession")
      resession.setup({
        autosave = {
          enabled = true,
          interval = 300,
          notify = false,
        },
      })

      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          -- Only load the session if nvim was started with no args
          if vim.fn.argc(-1) == 0 then
            -- Save these to a different directory, so our manual sessions don't get polluted
            resession.load(vim.fn.getcwd(), { dir = "dirsession", silence_errors = true })
          end
        end,
      })
      vim.api.nvim_create_autocmd("VimLeavePre", {
        callback = function()
          resession.save(vim.fn.getcwd(), { dir = "dirsession", notify = false })
        end,
      })
    end,
  }
}
