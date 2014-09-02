class FindReleasesToPromote < ActiveJob::Base
  def perform
    Release.not_promoted.each do |release|
      PromoMailer.new_release(release).deliver_later
    end
  end
end
