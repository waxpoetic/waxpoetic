# Local record for a Facebook event hosted by an +Artist+'s page.
class Event < ActiveRecord::Base
  belongs_to :artist

  before_validation :ensure_name_and_location

  validates :name,        presence: true
  validates :location,    presence: true
  validates :facebook_id, presence: true

  scope :latest, -> { order :starts_at }
  scope :upcoming, -> { where('starts_at >=', Time.zone.now).latest }
  scope :past, -> { where('starts_at <', Time.zone.now).latest }

  # API response from Facebook for the event with this record's
  # +facebook_id+.
  #
  # @return [Facebook::Event]
  def facebook_event
    @facebook_event ||= Facebook::Event.find facebook_id
  end

  # URL to this Facebook event.
  #
  # @return [String]
  def url
    "https://www.facebook.com/event/#{facebook_id}"
  end

  private

  # Load name and location from the +facebook_event+ if one exists.
  #
  # @private
  def ensure_name_and_location
    if facebook_event.present?
      self.name ||= facebook_event.name
      self.location ||= facebook_event.location
    end
  end
end
