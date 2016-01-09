require 'i18n'

module WaxPoetic
  module Seed
    class << self
      CATALOG_MODELS = %w(Artist Release Track)

      # Seed the Wax Poetic Records online store. Builds an admin user.
      def load!
        create_admin_user
        puts "seeding #{I18n.t('store.url')}, please wait for inline jobs to finish"
      end

      protected
      # Build the admin user from params in config/secrets.yml
      def create_admin_user
        User.create_admin Rails.application.secrets.admin_user
      end
    end
  end
end
