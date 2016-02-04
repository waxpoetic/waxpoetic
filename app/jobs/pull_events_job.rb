# Pull down Facebook events hosted by the page ID and 
class PullEventsJob < ActiveJob::Base
  queue_as :events

  def perform
    Artist.each do |artist|
      artist.page.events.each do |event|
        unless artist.tracks_event?(event)
          artist.events.create event.attributes
        end
      end
    end
  end
end
