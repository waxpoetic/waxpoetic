# Hook into when an order is first created and build a Passbook for this
# ticket.
Spree::Order.class_eval do
  has_many :tickets
  has_one :download

  remove_checkout_step :address
  remove_checkout_step :delivery

  insert_checkout_step :create_download,  before: :confirm, if: -> (o) { o.download? }
  insert_checkout_step :create_tickets,  before: :confirm, if: -> (o) { o.ticket? }

  # Public: Products associated with this order which can be downloaded.
  def downloadables
    variants.map do |variant|
      variant.saleable_type =~ /Release|Track/
    end
  end

  def download?
    downloadables.any?
  end

  def ticket?
    events.any?
  end

  private
  def create_tickets
    events.each { |event| tickets.create event: event }
  end

  def events
    saleables.select { |saleable| saleable == 'Event' }
  end

  def saleables
    line_items.map(&:product).map(&:saleable)
  end
end
