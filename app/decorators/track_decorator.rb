class TrackDecorator < Draper::Decorator
  delegate_all

  def title
    "#{artist.name} - #{name}"
  end
end
