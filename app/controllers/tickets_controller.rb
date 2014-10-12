class TicketsController < ApplicationController
  expose :ticket
  expose :event, :ancestor => :ticket
  expose :order, :ancestor => :ticket

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.pkpass { send_file ticket.pkpass.path, pkpass_file_opts }
      format.pdf # show.pdf.prawn
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
