module Facebook
  # A single Facebook event hosted by an +Artist+'s page.
  class Event < Model
    # Find all events hosted by the given +Facebook::Page+.
    #
    # @param [Facebook::Page] page
    # @param [Proc] block
    # @return [Array<Facebook::Event>] all events found for this page
    def self.hosted_by(page, &_block)
      Facebook.graph.get_objects('event', page: page.id).map do |params|
        new params
      end
    end

    # Only the attributes necessary for the +Event+ record.
    #
    # @return [Hash] of :name, :location, :description and :facebook_id
    def attributes
      {
        name: name,
        location: location,
        description: description,
        facebook_id: id
      }
    end
  end
end
