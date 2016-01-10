module Bitly
  # Handles short link creation through bit.ly.
  class ShortLink
    include ActiveModel::Model

    # The original URL to the object.
    #
    # @attr_accessor [String]
    attr_accessor :url

    # The generated URL for the object.
    #
    # @attr_reader [String]
    attr_reader :href

    validates :url, presence: true

    # Create a new short link.
    #
    # @return [Bitly::ShortLink]
    def self.create(params)
      link = new(params)
      link.save
      link
    end

    # Creates a new short link after validating that we have a track.
    #
    # @return [Boolean]
    def save
      valid? && create
    end

    # Tests if the short link was created.
    #
    # @return [Boolean]
    def persisted?
      href.present?
    end

    private

    # @private
    # @return [Boolean]
    def create
      @href = Bitly.client.shorten url
      true
    rescue
      false
    end
  end
end

