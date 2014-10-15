require 'decent_exposure/strong_parameters_strategy'

module WaxPoetic
  # A DecentExposure strategy that borrows from StrongParametersStrategy
  # but decorates all models before sending them to the view. It also
  # does not decorate on create as there are unknown problems with doing
  # that.
  class DecentExposureStrategy < DecentExposure::StrongParametersStrategy
    # Decorate all non-persisting methods.
    def resource
      return super if controller.action_name == 'create'
      super.decorate
    end
  end
end
