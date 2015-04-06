class List
  include ActiveModel::Model

  attr_accessor :id

  def subscribe(options={})
    mailchimp.lists.subscribe(options.merge(id: id))
  end

  def members
    mailchimp.lists.members(id: id)
  end

  private

  def mailchimp
    @mailchimp ||= Gibbon::API.new WaxPoetic.secrets.mailchimp_key
  end
end
