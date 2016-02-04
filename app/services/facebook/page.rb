require_relative 'facebook'

module Facebook
  # Represents an +Artist+'s Facebook page and the data contained within
  # it.
  class Page < Model
    def events
      Event.hosted_by self
    end
  end
end
