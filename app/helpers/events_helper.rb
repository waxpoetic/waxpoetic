module EventsHelper
  # Say you're going to this event on Facebook.
  def link_to_facebook(text, event)
    link_to text, event.facebook_event_url, class: 'button secondary'
  end

  # Add this event to your Calendar.
  def link_to_calendar(text, event)
    link_to text, event_path(event, :format => :ical), class: 'button secondary'
  end
end
