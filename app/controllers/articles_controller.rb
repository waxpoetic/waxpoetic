class ArticlesController < ApplicationController
  resource :article, scope: :latest

  expose :releases, scope: :latest

  # Home page, returns all articles and latest releases.
  #
  # @http [GET] /articles
  def index
    respond_with articles
  end

  # Show a single article.
  #
  # @http [GET] /articles/title-of-article
  def show
    respond_with article
  end
end
