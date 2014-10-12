require 'rails/railtie'

module WaxPoetic
  class Railtie < Rails::Railtie
    # Application configuration
    config.wax_poetic = ActiveSupport::OrderedOptions.new

    # A shim until we get to Rails 4.2
    config.active_job = ActiveSupport::OrderedOptions.new
  end
end
