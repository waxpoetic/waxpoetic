require_relative 'facebook'
require_relative 'facebook/not_found_error'

module Facebook
  # Mixin for loading Facebook data into the application.
  module Model
    extend ActiveSupport::Concern

    included do
      include ActiveModel::Validations

      # ID of this resource in Facebook.
      #
      # @attr_reader [String]
      attr_reader :id

      # Find a given attribute's value.
      delegate :[], to: :attributes

      # Configure this model's Facebook type.
      #
      # @example
      #   module Facebook
      #     class Resource
      #       include Model
      #
      #       self.type = 'foo'
      #     end
      #   end
      class_attribute :type
    end

    class_methods do
      # Find graph resource by its given ID.
      #
      # @return [Facebook::Model]
      def find(by_id)
        new by_id
      rescue NotFoundError => exception
        Rails.logger.debug exception.message
        nil
      end
    end

    # @param [String] from_id
    def initialize(from_id)
      @id = from_id
      fail NotFoundError type, id unless graph_object.present?
    end

    # All attributes as defined by the graph object.
    #
    # @return [Hash]
    def attributes
      @attributes ||= graph_object.data.symbolize_keys
    end

    # Look up values in the given graph object's attributes hash.
    #
    # @throw [NoMethodError] if method is not defined.
    # @return [String] value of the attribute if method is defined.
    def method_missing(method, *arguments)
      return super unless respond_to? method
      self[method] = *arguments if method.to_s =~ /\=\Z/
      self[method]
    end

    # Test if the given key is included in the attributes hash.
    #
    # @return [Boolean]
    def include?(key)
      attributes.keys.include? key
    end

    # Test if the given method name can be called on this object.
    #
    # @return [Boolean]
    def respond_to?(method)
      include?(method) || super
    end

    # Facebook graph resource type of this model, usually discovered by
    # looking up the class name and processing it to be a parameterized
    # and underscored +String+. However, it can be configured by doing
    # +self.type = 'foo'+ in the class definition.
    #
    # @return [String]
    def type
      self.class.type || self.class.name.parameterize.underscore
    end

    # Persist the given attributes back to Facebook.
    #
    # @return [Boolean] +true+ if attributes are valid and the response
    # succeeded, +false+ otherwise.
    def save
      valid? && update
    end

    private

    # Response from querying the Facebook graph about this particular
    # object.
    #
    # @private
    # @return [Koala::Facebook::API::Response]
    def graph_object
      @graph_object ||= Facebook.graph.get_object type, id: id
    end

    def update
      response = Facebook.graph.put_object type, id: id, data: attributes
      return true if response.success?
      errors.add :base, "Errors updating: #{response.errors}"
      false
    end
  end
end
