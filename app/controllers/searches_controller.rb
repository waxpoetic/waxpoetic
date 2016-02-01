# Search engine.
class SearchesController < ApplicationController
  expose :search, attributes: :search_params

  # Run a search query with pg multisearch.
  #
  # @http [GET] /search?q=search+query
  def show
    respond_with search
  end

  private

  # @private
  # @return [StrongParameters::Hash]
  def search_params
    params.permit :q
  end
end
