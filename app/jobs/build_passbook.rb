class BuildPassbook
  def perform(order)
    order.events.each do |event|
      Ticket.create event: event, order: order
    end
  end
end
