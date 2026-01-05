local openai = require("codecompanion.adapters.http.openai")

---@class CodeCompanion.HTTPAdapter.NanoGPT: CodeCompanion.HTTPAdapter
return {
  name = "nanogpt",
  formatted_name = "NanoGPT",
  roles = {
    llm = "assistant",
    user = "user",
  },
  opts = {
    stream = true,
    vision = false,
  },
  features = {
    text = true,
    tokens = true,
  },
  url = "https://nano-gpt.com//api/v1/chat/completions",
  env = {
    api_key = "NANOGPT_API_KEY",
  },
  headers = {
    Authorization = "Bearer ${api_key}",
    ["Content-Type"] = "application/json",
  },
  handlers = {
    setup = function(self)
      if self.opts and self.opts.stream then
        self.parameters.stream = true
      end
      return true
    end,

    --- Use the OpenAI adapter for the bulk of the work
    tokens = function(self, data)
      return openai.handlers.tokens(self, data)
    end,
    form_parameters = function(self, params, messages)
      return openai.handlers.form_parameters(self, params, messages)
    end,
    form_messages = function(self, messages)
      return openai.handlers.form_messages(self, messages)
    end,
    chat_output = function(self, data)
      return openai.handlers.chat_output(self, data)
    end,
    inline_output = function(self, data, context)
      return openai.handlers.inline_output(self, data, context)
    end,
    on_exit = function(self, data)
      return openai.handlers.on_exit(self, data)
    end,
  },
  schema = {
    ---@type CodeCompanion.Schema
    model = {
      order = 1,
      mapping = "parameters",
      type = "enum",
      desc = "ID of the model to use. See the model endpoint compatibility table for details on which models work with the Chat API.",
      default = "openai/gpt-5-nano",
      choices = {
         "openai/gpt-5.1-codex-mini",
         "openai/gpt-5.1-codex",
         "openai/gpt-5.2",
         "openai/gpt-5.2-chat",
         "openai/gpt-5.2-pro",
         "openai/gpt-5-nano",
         "claude-sonnet-4-5-20250929",
         "claude-sonnet-4-5-20250929-thinking",
         "claude-haiku-4-5-20251001",
      },
    },
  },
}
