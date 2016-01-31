require 'friendly_id'
require 'active_model/jobs'

ActiveSupport.on_load :active_record do
  # ActiveRecord::Base.extend FriendlyId
  ActiveRecord::Base.send :include, ActiveModel::Jobs
end
