ActiveSupport.on_load :active_record do
  ActiveRecord::Base.class_eval do
    extend FriendlyId

    include ActiveModel::Jobs
  end
end
