class ShortenTrackJob < ActiveJob::Base
  queue_as :default

  def perform(track)
    short_link = Bitly::ShortLink.create url: track.decorate.url
    track.update short_link: short_link.href if short_link.persisted?
  end
end
