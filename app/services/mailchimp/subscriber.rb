module Mailchimp
  class Subscriber
    include ActiveModel::Model

    attr_accessor :name
    attr_accessor :email
    attr_accessor :list_id

    validates :email, presence: true

    def self.create(name: '', email: '', list_id: WaxPoetic.secrets.mailchimp_list_id)
      subscriber = new(name: name, email: email, list_id: list_id)
      subscriber.save
      subscriber
    end

    def save
      valid? && create
    end

    private

    def create
      list.add self
    end

    def list
      @list ||= List.new list_id
    end
  end
end
