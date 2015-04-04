class TicketsController < ApplicationController
  resource :ticket
  expose :event, :ancestor => :ticket
  expose :order, :ancestor => :ticket

  # Render a purchased ticket as HTML (usually the starting point, as a
  # link from email), as a "pkpass" Passbook object, or as a PDF for
  # printing.
  def show
    respond_to do |format|
      format.html   { respond_with ticket }
      format.pkpass { send_file ticket.pkpass.path, pkpass_file_opts }
      format.pdf    { render pdf: ticket  }
    end
  end

  private
  def pkpass_file_opts
    {
      type: 'application/vnd.apple.pkpass',
      disposition: 'attachment',
      filename: "pass.pkpass"
    }
  end
end
