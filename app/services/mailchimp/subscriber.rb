module Mailchimp
  class Subscriber
    include ActiveModel::Model

    attr_accessor :name
    attr_accessor :email

    validates :email, presence: true

    def self.create(name: '', email: '')
      subscriber = new(name: name, email: email)
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
      @list ||= List.new
    end
  end
end
