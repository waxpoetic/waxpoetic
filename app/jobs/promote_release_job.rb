# Send out promotional emails and social media posts about a given +Release+.
class PromoteReleaseJob < ActiveJob::Base
  queue_as :releases

  # @param [Release] release
  def perform(release)
    %w(Facebook Twitter).each do |network|
      "#{network}::Post".constantize.create release
    end
  end
end
