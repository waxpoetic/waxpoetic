module Spree
  class Order
    after_create :build_passbook_ticket, :if => :ticket?

    private
    def build_passbook_ticket
      BuildPassbookTicket.enqueue self
    end

    def ticket?
      false
    end
  end
end
