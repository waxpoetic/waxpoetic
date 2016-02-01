class ArticlesController < ApplicationController
  resource :article

  def index
    respond_with articles
  end

  def show
    respond_with article
  end
end
