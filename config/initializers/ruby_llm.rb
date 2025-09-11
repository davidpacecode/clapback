RubyLLM.configure do |config|
  # config.openai_api_key = ENV["OPENAI_API_KEY"]
  config.anthropic_api_key = ENV["ANTHROPIC_API_KEY"]

  # config.default_model = "claude-sonnet-4-20250514"
  config.default_model = "claude-3-haiku-20240307"
end
