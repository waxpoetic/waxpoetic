# Generate a short URL for the Track with Bitly.
class GenerateTrackLinkJob < ActiveJob::Base
  attr_reader :track

  def perform(track)
    @track = track.decorate
    track.update_attributes short_url: short_url_for_track
  end

  private
  def short_url_for_track
    Bitly.client.shorten track.url, track.slug
  end
end
