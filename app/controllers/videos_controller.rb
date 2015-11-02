class VideosController < ApplicationController
  include ApplicationHelper
  def index
    @video = Video.first
    now_playing(@video)
    if !@video.nil?
      Video.first.delete
    end
  end
end
