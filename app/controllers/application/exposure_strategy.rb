module Application
  class ExposureStrategy < DecentExposure::StrongParametersStrategy
    def collection_resource
      collection_decorator.new super
    end

    def singular_resource
      super.decorate
    end
  end
end
