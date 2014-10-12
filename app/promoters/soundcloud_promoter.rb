require 'soundcloud'

# Upload this Track to Wax Poetic's Soundcloud account.

class SoundcloudPromoter < WaxPoetic::Promoter
  # Enumerate through each Track and upload it to Wax Poetic's
  # Soundcloud account.
  def promote!(release, options={})
    release.tracks.each do |track|
      response = upload track
      if response.success?
        logger.info "'#{track}' has been uploaded to Soundcloud"
        true
      else
        logger.error "Error uploading '#{track}' to Soundcloud"
        logger.error response.body
        false
      end
    end
  end

  # Fails validation when we can't access Soundcloud.
  def connected?
    soundcloud.get('/me').success?
  end

  protected
  def upload(track)
    soundcloud.post '/me/tracks', track: track.soundcloud_attributes
  end

  private
  def soundcloud
    @soundcloud ||= Soundcloud.new credentials
  end
end
