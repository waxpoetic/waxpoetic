module WaxPoetic
  class Promoter
    # A sub-module that defines methods for querying all promoters.
    module Collection
      include Enumerable

      # Return all Promoter objects as a collection.
      def all
        @promoters ||= Rails.configuration.promote_to.map do |driver|
          create driver
        end
      end

      # Enumerate over the promoters.
      delegate :each, to: :all

      # Define a new promoter.
      def create(driver)
        "#{driver.to_s.classify}Promoter".constantize.new \
          credentials: credentials_for(driver), driver: driver
      end

      private

      def credentials_for(driver)
        WaxPoetic.secrets[driver] || {}
      end
    end
  end
end
