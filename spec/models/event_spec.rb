# == Schema Information
#
# Table name: events
#
#  id           :integer          not null, primary key
#  name         :string
#  description  :text
#  ticket_price :string
#  location     :string
#  latitude     :float
#  longitude    :float
#  starts_at    :datetime
#  ends_at      :datetime
#  created_at   :datetime
#  updated_at   :datetime
#  slug         :string
#  is_saleable  :boolean          default(TRUE)
#
# Indexes
#
#  index_events_on_latitude   (latitude)
#  index_events_on_longitude  (longitude)
#

require 'rails_helper'

RSpec.describe Event, :type => :model do
  subject do
    Event.new \
      name: "A really fun party",
      description: "Here's that lineup",
      ticket_price: 15.00,
      location: "Philadelphia, PA",
      starts_at: 1.day.from_now.to_datetime
  end

  test_validations_for %w(name location ticket_price starts_at)

  it "geocodes location" do
    expect(subject).to be_valid
    expect(subject.latitude).to be_present
    expect(subject.longitude).to be_present
  end
end
