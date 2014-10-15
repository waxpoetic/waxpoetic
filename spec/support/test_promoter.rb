require 'wax_poetic/promoter'

class TestPromoter < WaxPoetic::Promoter
  attr_reader :promoted_releases

  before_initialize :reload!

  def promote!(release, options={})
    @promoted_releases << release
    true
  end

  def reload!
    @promoted_releases = []
  end
end
