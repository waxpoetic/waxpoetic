class PromoteReleaseJob < ActiveJob::Base
  attr_reader :release

  def perform(release)
    @release = release
    logger.warn "No promoters configured" unless WaxPoetic::Promoter.any?

    WaxPoetic::Promoter.each do |promoter|
      promoter.promote release
    end
  end
end
