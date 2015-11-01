class VideosController < ApplicationController
  def index
    @video = Video.first
    Video.first.delete
  end
end
