class List
  include ActiveModel::Model

  def subscribe(options={})
    mailchimp.lists.subscribe(options.merge(id: id))
  end

  def members
    mailchimp.lists.members(id: id)
  end
end
