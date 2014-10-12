class Ticket
  include ActiveModel::Model

  attr_accessor :event, :order
  attr_reader :pkpass

  validates :event, presence: true
  validates :order, presence: true

  # Build and save a new Ticket as a PKPass.
  def self.create(attrs={})
    ticket = new(attrs)
    ticket.save
    ticket
  end

  # Save this Ticket immediately.
  def save
    valid? and upload and notify
  end

  # The ticket number is calculated using the given event.id and
  # order.id.
  def number
    "#{event.id}-#{order.id}"
  end

  # Passbook attributes for this ticket, in Ruby.
  def attributes
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

  # Passbook attributes for this ticket, in JSON.
  def to_json
    attributes.to_json
  end

  # A compiled PKPass archive of this Ticket.
  def pkpass
    @pkpass ||= Passbook::PKPass.new to_json
  end

  private
  def upload
    uploader.store! pkpass.file
  end

  def notify
    UserMailer.ticket_available(order.user).deliver
  end

  def uploader
    TicketUploader.new
  end
end
