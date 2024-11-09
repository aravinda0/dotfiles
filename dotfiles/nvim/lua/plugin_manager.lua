local bootstrap_lazy_nvim = function()
   local lazy_nvim_path = vim.fn.stdpath("data") .. "lazy/lazy.nvim"
   if not vim.loop.fs_stat(lazy_nvim_path) then
      vim.fn.system({
         "git",
         "clone",
         "--filter=blob:none",
         "https://github.com/folke/lazy.nvim.git",
         "--branch=stable",
         lazy_nvim_path,
      })
   end
   vim.opt.rtp:prepend(lazy_nvim_path)
end

bootstrap_lazy_nvim()
require("lazy").setup("plugins", opts)
