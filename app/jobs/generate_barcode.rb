require 'barby'
require 'barby/barcode/code_128'
require 'barby/outputter/png_outputter'
require 'tempfile'

# Generate a barcode for this ticket and then upload it to S3.

class GenerateBarcode < ActiveJob::Base
  attr_reader :ticket

  def perform(ticket)
    @ticket = ticket
    @ticket.barcode.store! temp_file.path
  end

  private
  def barcode
    @barcode ||= Barby::Code128B.new ticket.number
  end

  def temp_file
    @temp_file ||= begin
      file = Tempfile.new "#{ticket.number}.png"
      file.write barcode.to_png
    end
  end
end
