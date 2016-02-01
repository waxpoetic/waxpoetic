# Upload a +Track+ to Soundcloud in the background.
class UploadTrackJob < ActiveJob::Base
  queue_as :uploads

  # @param [Track] track
  def perform(track)
    Soundcloud::Track.create(
      name: track.title,
      asset_data: track.asset_data
    )
  end
end
