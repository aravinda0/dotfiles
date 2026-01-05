
return {
   {
      "olimorris/codecompanion.nvim",
      dependencies = {
         "nvim-lua/plenary.nvim",
         "nvim-treesitter/nvim-treesitter",
      },
      opts = {
         strategies = {
            chat = {
               -- adapter = "gemini",
               adapter = "nanogpt",
               model = "openai/gpt-5-nano",
            },
            inline = {
               adapter = "gemini",
            },
         },
         adapters = {
            http = {
               nanogpt = function() 
                  return require("ai.nanogpt_adapter")
               end
            }
         }
      },
   },
}
