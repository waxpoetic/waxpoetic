require 'passbook'

# Configure credentials for using Apple's Passbook service. This app can
# export Event tickets in passbook's format for use on iOS devices.

Passbook.configure do |config|
  config.wwdc_cert = Rails.configuration.secrets.passbook.wwdc_cert_path
  config.p12_cert = Rails.configuration.secrets.passbook.p12_cert_path
  config.p12_password = Rails.configuration.secrets.passbook.p12_password
end
