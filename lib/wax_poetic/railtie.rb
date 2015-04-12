require 'rails/railtie'
require 'wax_poetic'

module WaxPoetic
  # Extensions to the Rails initialization process.
  class Railtie < Rails::Railtie
    # Create a namespace for app configuration
    config.wax_poetic = ActiveSupport::OrderedOptions.new

    # Initialize Spree
    config.to_prepare do
      # Load application's model / class decorators
      Dir.glob(File.join(File.dirname(__FILE__), "../app/**/*_decorator*.rb")) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end

      # Load application's view overrides
      Dir.glob(File.join(File.dirname(__FILE__), "../app/overrides/*.rb")) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end

    # Preload app folders
    config.after_initialize do |app|
      %w(overrides patches products promoters).each do |folder|
        app.config.paths.add "app/#{folder}", eager_load: true
      end
    end
  end
end
