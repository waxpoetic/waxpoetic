module Mailchimp
  # Represents a list on Mailchimp that fans can be subscribed to.
  class List
    attr_reader :id
    attr_reader :api_key

    def initialize(from_id)
      @id = from_id
      @api_key = WaxPoetic.secrets.mailchimp_api_key
    end

    def add(subscriber)
      list.subscribers.create(
        email: subscriber.email,
        params: { NAME: subscriber.name }
      ).success?
    end

    private

    def list
      @list ||= gibbon.lists.find id
    end

    def gibbon
      @gibbon ||= Gibbon::Client.connect api_key
    end
  end
end
