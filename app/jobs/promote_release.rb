class PromoteRelease < ActiveJob::Base
  attr_reader :release

  def perform(release)
    @release = release
    logger.warn "No promoters configured" unless WaxPoetic::Promoter.any?

    WaxPoetic::Promoter.each do |promoter|
      promoter.promote release, options_for(promoter)
    end
  end

  private
  def options_for(promoter)
    case promoter
    when :email
      { to: Subscriber.all }
    else
      {}
    end
  end
end
