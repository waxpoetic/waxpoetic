class TicketsController < ApplicationController
  respond_to :html, :csv

  expose :event
  expose :tickets, ancestor: :event, order: :number

  # Show all tickets for this event.
  def index
    respond_to do |format|
      format.html { respond_with tickets }
      format.csv  { render csv: tickets.to_csv }
    end
  end
end
