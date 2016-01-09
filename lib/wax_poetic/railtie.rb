require 'rails/railtie'
require 'wax_poetic'

module WaxPoetic
  # Extensions to the Rails initialization process.
  class Railtie < Rails::Railtie
    # Preload app folders
    config.after_initialize do |app|
      %w(overrides patches products promoters).each do |folder|
        app.config.paths.add "app/#{folder}", eager_load: true
      end
    end
  end
end
