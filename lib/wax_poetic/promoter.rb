require 'wax_poetic/promoter/model'
require 'wax_poetic/promoter/collection'

module WaxPoetic
  # Base object for Promoter classes, who have the responsibility of
  # promoting a Release using some sort of API. This particular class is
  # responsible for defining the public interface for each Promoter
  # subclass.
  class Promoter
    include Model
    extend Collection

    # Ensure all attributes get saved into a Hash.
    def initialize(attrs = {})
      run_callbacks :initialize do
        @attributes = attrs.with_indifferent_access
        super
      end
    end

    # This is what is actually called from the API's point of view.
    def promote(release, options = {})
      return false unless valid?
      promote! release, options
    end

    # The base Promoter won't work with `promote!`.
    def promote!(_release, _options = {})
      fail NoMethodError, "#{self.class.name} must define the 'promote!' method"
    end

    # Override this to fail validation when the client can't be
    # connected.
    def connected?
      true
    end
  end
end
