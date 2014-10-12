require 'rails/railtie'

module WaxPoetic
  class Railtie < Rails::Railtie
    # Application configuration
    config.wax_poetic = ActiveSupport::OrderedOptions.new

    config.wax_poetic.aws_key = Rails.application.secrets.aws[:access_key_id]
    config.wax_poetic.aws_secret = Rails.application.secrets.aws[:secret_access_key]

    # A shim until we get to Rails 4.2
    config.active_job = ActiveSupport::OrderedOptions.new
  end
end
