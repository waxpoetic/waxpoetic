# View-level decorations for Release objects.
class ReleaseDecorator < Draper::Decorator
  delegate_all

  def title
    "#{artist.name} - #{name}"
  end
end
