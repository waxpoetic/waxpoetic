# A DecentExposure strategy that borrows from StrongParametersStrategy
# but decorates all models before sending them to the view.
class DecoratedStrongParametersStrategy < DecentExposure::StrongParametersStrategy
  def resource
    r = super.tap do |r|
      unless r.respond_to?(:decorate)
        r.class.send(:include, Draper::Decoratable)
      end
    end

    r.decorate
  end
end
