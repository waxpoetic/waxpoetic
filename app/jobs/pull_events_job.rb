# Pull down Facebook events hosted by the page ID and
class PullEventsJob < ActiveJob::Base
  queue_as :events

  def perform
    Artist.each do |artist|
      artist.page.events.select do |event|
        artist.tracks_event? event
      end.each do |event|
        artist.events.create event.attributes
      end
    end
  end
end
