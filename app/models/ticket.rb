class Ticket < ActiveRecord::Base
  belongs_to :event
  belongs_to :order

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

  # Passbook attributes for this Ticket.
  def passbook_attributes
    {
      "formatVersion" => 1,
      "passTypeIdentifier" => "pass.com.waxpoeticrecords.event_ticket",
      "serialNumber" => number,
      "teamIdentifier" => team_id,
      "organizationName" => "Wax Poetic Music, LLC",

      "description" => "'#{event.name}' Ticket",
      "logoText" => event.name,
      "foregroundColor" => "rgb(255, 255, 255)",
      "backgroundColor" => "rgb(135, 129, 189)",
      "labelColor" => "rgb(45, 54, 129)",

      "barcode" => {
        "message" => "WXE-#{number}",
        "format" => "PKBarcodeFormatPDF417",
        "messageEncoding" => "iso-8859-1"
      }
    }
  end

  # A compiled PKPass archive of this Ticket.
  def pkpass
    @pkpass ||= Passbook::PKPass.new passbook_attributes.to_json
  end

  private
  def notify_user
    UserMailer.ticket_available(user).deliver
  end

  def generate_barcode
    GenerateBarcode.enqueue self
  end
end
