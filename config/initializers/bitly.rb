require 'bitly'

Bitly.configure do |config|
  config.api_version = 3
  config.access_token = WaxPoetic.secrets.bitly_api_key
end
