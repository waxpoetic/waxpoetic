require 'wax_poetic/store/payment_gateway'

module WaxPoetic
  # Code for Spree-related tasks that need to be run on seed as well as
  # in tasks.
  module Store
    class << self
      def load_seed
        configure_store and generate_products and define_payment_method
        puts "seeded the waxpoetic online store"
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
          release.cover.store! release.decorate.seed_cover_file
          release.save
          release.sell!
        end
      end

      def define_payment_method
        Stripe::PaymentMethod.create payment_gateway.params
      end

      private
      def payment_gateway
        PaymentGateway.fetch
      end
    end
  end
end
