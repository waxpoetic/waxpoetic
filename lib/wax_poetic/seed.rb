module WaxPoetic
  # Code for Spree-related tasks that need to be run on seed as well as
  # in tasks.
  module Seed
    class << self
      def load!
        configure_store and generate_products and generate_artist_images
        puts "seeded waxpoeticrecords.com"
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
        Release.without_product.each do |release|
          release.cover.store! cover_file_for(release)
          release.save
          release.send :generate_product
        end
      end

      def generate_artist_images
        Artist.each do |artist|
          artist.photo.store! cover_file_for(artist)
          artist.save
        end
      end

      private
      def cover_file_for(model)
        File.new "#{Rails.root}/tmp/images/#{model.name.parameterize}.jpg"
      end
    end
  end
end
