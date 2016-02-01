module Application
  # Configure +DecentExposure+ to decorate collections and singular
  # resources.
  class ExposureStrategy < DecentExposure::StrongParametersStrategy
    # Return a decorated collection resource.
    #
    # @return [Draper::CollectionDecorator]
    def collection_resource
      super.decorate_collection
    end

    # Return a singular decorated model resource.
    #
    # @return [Draper::Decorator]
    def singular_resource
      super.decorate
    end
  end
end
