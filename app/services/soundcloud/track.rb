module Soundcloud
  class Track
    attr_accessor :track

    delegate :artist, :release, to: :track

    def self.create(from_track)
      new(track: from_track).tap do |soundcloud_track|
        soundcloud_track.save
      end
    end

    def save
      valid? && create
    end

    def create
      client.post '/tracks', track: attributes
    end

    def title
      @title ||= "#{artist.name} - #{track.name} [#{release.catalog_number}]"
    end

    def file
      @file ||= File.new Refile.store.read audio_file_path
    end

    def attributes
      {
        title: title,
        asset_data: file,
        download: false,
        private: true
      }
    end

    private

    def client
      @client ||= Soundcloud.new WaxPoetic.secrets.soundcloud
    end
  end
end
