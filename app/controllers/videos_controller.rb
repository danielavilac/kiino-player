class VideosController < ApplicationController
  def index
    @video = Video.first
    Video.first.delete if !@video.nil?
  end
end
