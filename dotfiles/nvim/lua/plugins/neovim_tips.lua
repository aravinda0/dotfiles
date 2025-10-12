return {
   "saxon1964/neovim-tips",
   version = "*", -- Only update on tagged releases
   dependencies = {
      "MunifTanjim/nui.nvim",
      "MeanderingProgrammer/render-markdown.nvim"
   },
   opts = {
      user_file = vim.env.HOME .. "/st/etc/app/nvim/neovim_tips/user_tips.md",
      user_tip_prefix = "[User] ",
      warn_on_conflicts = true,
      daily_tip = 1, -- 0 = off, 1 = once per day, 2 = every startup
   },
}
