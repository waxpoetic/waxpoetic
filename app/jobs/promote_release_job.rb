# Send out promotional emails and social media posts about a given +Release+.
class PromoteReleaseJob < ActiveJob::Base
  queue_as :releases

  # @param [Release] release
  def perform(release)
    [ Facebook::Post, Twitter::Tweet ].each do |social_media_post|
      social_media_post.create release
    end
  end
end
