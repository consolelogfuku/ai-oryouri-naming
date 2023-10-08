require 'deepl'
require 'dotenv'
Dotenv.load

DeepL.configure do |config|
  config.auth_key = ENV.fetch('DEEPL_AUTH_KEY', nil)
  config.host = 'https://api-free.deepl.com'
end
