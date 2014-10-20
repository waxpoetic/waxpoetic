class PodcastsController < ApplicationController
  authenticated_resource :podcast do
    format :html, :rss
    search :name, :number
    modify :name, :file, :description, :number
  end

  def index
    respond_with podcasts
  end

  def show
    respond_to do |format|
      format.html { respond_with podcast }
      format.wav  { redirect_to podcast.enclosure.url }
      format.rss  { redirect_to podcast_path(format: 'rss') }
    end
  end

  def create
    podcast.save
    respond_with podcast
  end

  def update
    podcast.update_attributes edit_params
    respond_with podcast
  end

  def destroy
    podcast.destroy
    respond_with podcast
  end
end
