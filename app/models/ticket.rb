class Ticket < ActiveRecord::Base
  belongs_to :event
  belongs_to :order, class_name: 'Spree::Order'

  has_one :user, :through => :order

  validates :event, presence: true
  validates :order, presence: true

  after_create :notify_user, :generate_barcode

  mount_uploader :barcode, ImageUploader

  # The ticket number is calculated using the given event.id and
  # order.id.
  def number
    @number ||= "#{event.id}-#{order.id}"
  end

  def purchaser
    order.bill_address.full_name
  end
end