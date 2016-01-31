module Facebook
  # Thrown when a Facebook resource cannot be found by its given ID.
  class NotFoundError < StandardError
    def initialize(type, id)
      super "Facebook #{type} cannot be found by ID='#{id}'"
    end
  end
end
