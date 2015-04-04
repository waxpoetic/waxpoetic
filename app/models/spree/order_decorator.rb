# Hook into when an order is first created and build a Passbook for this
# ticket.
Spree::Order.class_eval do
  after_create :record_ticket_purchase, :if => :ticket_purchased?

  private
  def record_ticket_purchase
    event.tickets.create order: self
  end

  def ticket_purchased?
    event.present?
  end

  def event
    Event.find_by_product_id line_items.variants.pluck(:product_id)
  end
end
