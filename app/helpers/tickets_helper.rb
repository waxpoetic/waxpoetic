module TicketsHelper
  # Link to the .pkpass for this ticket.
  def link_to_passbook(text, ticket)
    link_to text, ticket_path(ticket, :format => :pdf), class: 'button' %>
  end

  # Link to the printable PDF for this ticket, includes the barcode.
  def link_to_pdf(text, ticket)
    link_to text, ticket_path(ticket, :format => :pdf), class: 'button success' %>
  end
end
