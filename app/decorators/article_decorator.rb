# HTML presenter for blog articles.
class ArticleDecorator < ApplicationDecorator
  delegate_all

  # Timestamp for article.
  #
  # @return [String]
  def date
    model.released_on.strftime '%B %e, %Y'
  end
end
