class PodcastDecorator < Draper::Decorator
  delegate_all
  include MarkdownHelper

  def description
    markdown model.description
  end
end
