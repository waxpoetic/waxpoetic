require 'active_job'
require 'wax_poetic'

# Set ActiveJob's queue adapter.

ActiveJob::Base.queue_adapter = if WaxPoetic.live?
  :sidekiq
else
  :inline
end

module ActiveJob
  class Base
    # Make sure we have access to the Rails log.
    def logger
      Rails.logger
    end

    def self.perform_now(object)
      job = new
      job.perform object
      job
    end
  end
end
