class ArticlesController < ApplicationController
  resource :article, scope: :latest

  expose :releases, scope: :latest

  expose :podcast_episodes do
    articles.where.not audio: nil
  end

  # Home page, returns all articles and latest releases.
  #
  # @http [GET] /
  def home
    render 'home'
  end

  # @http [GET] /articles
  def index
    respond_with articles
  end

  # View podcast episodes.
  #
  # @http [GET] /articles/podcast
  # @http [GET] /articles/podcast.rss
  def podcast
    respond_to do |format|
      format.html { render 'podcast' }
      format.rss  { render rss: podcast_episodes }
    end
  end

  # Show a single article.
  #
  # @http [GET] /articles/title-of-article
  def show
    respond_with article
  end
end
