# A DecentExposure strategy that borrows from StrongParametersStrategy
# but decorates all models before sending them to the view.
class DecoratedStrongParametersStrategy < DecentExposure::StrongParametersStrategy
  # Decorate all non-persisting methods.
  def resource
    if controller.action_name == 'create'
      super
    else
      super.decorate
    end
  end
end
