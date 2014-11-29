require 'wax_poetic/promoter'
require 'wax_poetic/logger'
require 'wax_poetic/railtie'
require 'wax_poetic/seed'
require 'wax_poetic/temporary_authentication'

module WaxPoetic
  class << self
    # Configuration specific to WaxPoetic library or application code.
    # Namespaced so as not to pollute the global `config` object, this
    # shorthand allows for quicker access to the app configuration.
    def config
      Rails.configuration.wax_poetic
    end

    # Normally somewhat cumbersome to type out, this shorthand gives
    # quick access to the app secret keys so you can use them in
    # credentials throughout the app.
    def secrets
      Rails.application.secrets
    end

    # Test whether we are on a staging or production environment. Useful
    # for seeing whether we should be connecting to outside services or
    # mocking out their responses in runtime.
    def live?
      !!config.live
    end

    # Shorthand to the logger for library code.
    def logger
      @logger ||= WaxPoetic::Logger.new
    end

    # Model classes which are part of the Wax Poetic catalog.
    def catalog_models
      [Artist, Release, Track]
    end
  end
end
