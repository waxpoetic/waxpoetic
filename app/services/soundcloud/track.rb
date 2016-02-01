module Soundcloud
  # An uploaded track on Soundcloud.
  class Track
    # @attr_accessor [Track]
    attr_accessor :track

    # @attr_reader [Soundcloud::Response]
    attr_reader :response

    delegate :artist, :release, :name, to: :track
    delegate :catalog_number, to: :release
    delegate :name, to: :artist, prefix: :artist
    delegate :permalink_url, to: :response, allow_nil: true

    validates :track, presence: true

    # Create a new track on Soundcloud.
    #
    # @return [Soundcloud::Track]
    def self.create(from_track)
      new(track: from_track).tap do |soundcloud_track|
        soundcloud_track.save
      end
    end

    # Save this track to Soundcloud.
    #
    # @return [Boolean]
    def save
      valid? && create && persist
    end

    # Composed title of the track.
    #
    # @return [String]
    def title
      @title ||= "#{artist_name} - #{name} [#{catalog_number}]"
    end

    # Audio file to upload.
    #
    # @return [File]
    def file
      @file ||= File.new Refile.store.read(audio_file_path)
    end

    # All attributes of the track.
    #
    # @return [Hash]
    def attributes
      {
        title: title,
        asset_data: file,
        download: false,
        private: true
      }
    end

    # Test if we have sent the create request.
    #
    # @return [Boolean]
    def persisted?
      response.present? && response.success?
    end

    private

    # @private
    # @return [Soundcloud::Response]
    def create
      @response = client.post '/tracks', track: attributes
    end

    # @private
    # @return [Boolean]
    def persist
      return false unless persisted?
      track.update soundcloud_url: permalink_url
    end

    # @private
    # @return [Soundcloud::Client]
    def client
      @client ||= Soundcloud.new WaxPoetic.secrets.soundcloud
    end

    # @private
    # @return [String]
    def audio_file_path
      Refile.attachment_url track, :audio
    end
  end
end
