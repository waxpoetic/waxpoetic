module WaxPoetic
  # Code for Spree-related tasks that need to be run on seed as well as
  # in tasks.
  module Seed
    class << self
      def load!
        create_admin_user
        configure_store
        generate_products
        generate_artist_images
        puts "seeded waxpoeticrecords.com"
      end

      def create_admin_user
        User.create Rails.application.secrets.admin_user.merge(is_admin: true)
      end

      def configure_store
        Spree::Store.first.update_attributes \
          name: "Wax Poetic Records",
          meta_description: "An open-source record label with a focus on electronic music.",
          meta_keywords: "open-source, record, label",
          seo_title: "Wax Poetic Records: An open-source record label",
          url: "waxpoeticrecords.com"
      end

      def generate_products
        WaxPoetic.saleables.each do |model|
          model.without_product.each do |record|
            record.image.store! image_file_for(record) if record.respond_to? :image
            record.save
            record.enqueue_product_creation
          end
        end
      end

      def generate_artist_images
        Artist.all.each do |artist|
          artist.image.store! image_file_for(artist)
          artist.save
        end
      end

      private
      def image_file_for(model)
        File.new "#{Rails.root}/tmp/images/#{model.name.parameterize}.jpg"
      end
    end
  end
end
