require 'i18n'

module WaxPoetic
  # Code for Spree-related tasks that need to be run on seed as well as
  # in tasks.
  module Seed
    class << self
      # Seed the Wax Poetic Records online store. Builds an admin user,
      # sets up the Spree store, and fills it in with products based on
      # the saleable items in our whitelisted fixture data.
      def load!
        create_admin_user and configure_store
        puts "seeded #{I18n.t('store.url')}"
      end

      protected
      # Build the admin user from params in config/secrets.yml
      def create_admin_user
        User.create_admin Rails.application.secrets.admin_user
      end

      # Configure store params using the params in config/locales/en.yml
      def configure_store
        Spree::Store.first.update_attributes(
          name: I18n.t('store.name'),
          meta_description: I18n.t('store.description'),
          meta_keywords: I18n.t('store.keywords'),
          seo_title: I18n.t('store.title'),
          url: I18n.t('store.url')
        )
      end

      # Ensure the image exists then just run model callbacks to ensure
      # the product gets generated.
      def generate_products
        WaxPoetic.saleables.each do |model|
          model.without_product.each do |record|
            record.image.store! image_file_for(record)
            record.save
          end
        end
      end

      # Upload artist images from the tmp dir.
      def generate_artist_images
        Artist.all.each do |artist|
          artist.image.store! image_file_for(artist)
          artist.save
        end
      end

      private
      def image_file_for(model)
        File.new path_to_jpg(model.name.parameterize)
      end

      def path_to_jpg(filename)
        "#{Rails.root}/tmp/images/#{filename}.jpg"
      end
    end
  end
end
