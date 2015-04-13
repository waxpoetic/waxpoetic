require 'wax_poetic/railtie'

# The Wax Poetic Records online store.
module WaxPoetic
  extend ActiveSupport::Autoload

  %w(
    product
    promoter
    temporary_authentication
    logger
    product_variant
    promoter
    seed
    temporary_policy
  ).map(&:classify).each do |dependency|
    autoload dependency.to_sym
  end

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
      Rails.env =~ /production|staging/
    end

    # Shorthand to the logger for library code.
    def logger
      Rails.logger
    end
  end
end
