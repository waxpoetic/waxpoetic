# HTTP API and routes for accessing the blog articles and Podcast
# episodes on WaxPoeticRecords.com. Also serves the homepage with
# ancillary content such as the latest releases.
class ArticlesController < ApplicationController
  resource :article, scope: :latest

  expose :releases, scope: :latest
  expose :episodes, class_name: 'Article', scope: :podcast

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

  # View podcast episodes, which are any +Article+ with an +audio+
  # enclosure attachment.
  #
  # @http [GET] /podcast
  # @http [GET] /podcast.rss
  def podcast
    respond_to do |format|
      format.html # podcast.html.haml
      format.rss  # podcast.rss.builder
    end
  end

  # Show a single article.
  #
  # @http [GET] /articles/title-of-article
  def show
    respond_with article
  end
end
