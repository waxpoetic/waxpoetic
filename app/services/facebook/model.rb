require_relative 'facebook'
require_relative 'facebook/not_found_error'

module Facebook
  # Base class for all model record objects from the Facebook API.
  #
  # @api Facebook
  class Model
    include ActiveModel::Model

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

    class << self
      # Find graph resource by its given ID.
      #
      # @return [Facebook::Model]
      def find(by_id)
        new by_id
      rescue NotFoundError => exception
        Rails.logger.debug exception.message
        nil
      end

      # Facebook graph resource type of this model, usually discovered by
      # looking up the class name and processing it to be a parameterized
      # and underscored +String+. However, it can be configured by doing
      # +self.type = 'foo'+ in the class definition.
      #
      # @return [String]
      def type
        @type ||= name.parameterize.underscore
      end
    end

    # @param [String] from_id
    def initialize(from_id)
      @id = from_id
      fail NotFoundError self.class.type, id unless get.present?
    end

    # All attributes as defined by the graph object.
    #
    # @return [Hash]
    def attributes
      @attributes ||= get.data.symbolize_keys
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

    # Persist the given attributes back to Facebook.
    #
    # @return [Boolean] if attributes are valid and the response
    # succeeded
    def save
      valid? && put
    end

    # Test if this record has been saved to the Facebook graph.
    #
    # @return [Boolean]
    def persisted?
      id.present?
    end

    # Test if this record has yet to be saved to the Facebook graph.
    #
    # @return [Boolean]
    def new_record?
      !persisted?
    end

    private

    # Response from querying the Facebook graph about this particular
    # object.
    #
    # @private
    # @return [Koala::Facebook::API::Response]
    def get
      @graph ||= Facebook.graph.get_object type, id: id
    end

    # Write the attributes in memory back to the Facebook API.
    #
    # @private
    # @return [Boolean] if response was successful
    def put
      Facebook.graph.put_object(type, **payload).tap do |response|
        errors.add :base, response.body
      end.success?
    end

    # @private
    # @return [Hash]
    def payload
      if new_record?
        { data: attributes }
      else
        { id: id, data: attributes }
      end
    end
  end
end
