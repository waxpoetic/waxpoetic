require 'wax_poetic/decent_exposure_strategy'
require 'wax_poetic/railtie'

module WaxPoetic
  class << self
    def config
      Rails.configuration.wax_poetic
    end

    def live?
      !!config.live
    end
  end
end
