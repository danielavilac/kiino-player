class VideosController < ApplicationController
  include ApplicationHelper
  def index
    @videos = Video.all
    @video = Video.first
    now_playing(@video)
    if !@video.nil?
      Video.first.delete
    end
  end
end
