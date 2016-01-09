require 'active_support/concern'
require 'active_model'

module WaxPoetic
  class Promoter
    # This module is for defining ActiveModel extensions and validations
    # that are pertinent toward the main model framework, but are not
    # part of the public API. They are not optional.
    module Model
      extend ActiveSupport::Concern

      included do
        include ActiveModel::Model
        include ActiveModel::Callbacks

        attr_reader :attributes
        attr_accessor :credentials, :driver

        validates :credentials, presence: true
        validate :client_connected

        define_model_callbacks :initialize, :promote
      end

      # The logger class for promoter objects. Uses a log tag based on
      # the promoter's class name.
      def logger
        @logger ||= WaxPoetic.logger
      end

      # Test equalization based on the driver param.
      def ==(other_promoter)
        driver == other_promoter.driver
      end

      def credentials
        @credentials.try :with_indifferent_access
      end

      private

      def client_connected
        unless connected?
          errors.add driver_client_name, 'client could not connect'
        end
      end

      def driver_client_name
        driver || :base
      end

      def driver_class_name
        "#{driver_client_name.to_s.classify}Promoter"
      end
    end
  end
end
