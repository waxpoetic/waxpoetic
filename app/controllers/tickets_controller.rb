class TicketsController < ApplicationController
  respond_to :html
  resource :ticket
  expose :event, :ancestor => :ticket
  expose :order, :ancestor => :ticket

  # Render a purchased ticket as HTML (usually the starting point, as a
  # link from email), as a "pkpass" Passbook object, or as a PDF for
  # printing.
  def show
    respond_with ticket
  end
end
