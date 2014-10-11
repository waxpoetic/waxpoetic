require 'passbook'

# Configure credentials for using Apple's Passbook service. This app can
# export Event tickets in passbook's format for use on iOS devices.

Passbook.configure do |config|
  Rails.configuration.secrets.passbook.keys.each do |setting|
    config.send "#{setting}=", Rails.configuration.secrets.passbook[setting]
  end
end
