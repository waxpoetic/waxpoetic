class User < ActiveRecord::Base
  # Thrown when a +User+ can't be found by a given token.
  class NotAuthorizedError < StandardError
    def initialize(params)
      super "User could not be found with params '#{params}'"
    end
  end
end
