# Hook into when an order is first created and build a Passbook for this
# ticket.
Spree::Order.class_eval do
  after_create :build_passbook, :if => :ticket_purchased?

  private
  def build_passbook
    BuildPassbook.enqueue self
  end

  def ticket_purchased?
    events.any?
  end

  def events
    Event.where product_id: line_items.variants.pluck(:product_id)
  end
end
