prawn_document() do |pdf|
  pdf.text ticket.event.name
  pdf.text ticket.barcode
end
