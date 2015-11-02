class Api::V1::VideosController < ApplicationController
  include ApplicationHelper
  before_action :verify_token

  def push
    user = params[:user_name]
    team = params[:team_name]
    channel = params[:channel_name]
    text = params[:text]
    url = text.split(' ').first
    info = youtube_information(url)

    if (valid_youtube_url?(url))
      Video.create(url: url, user: user, team: team, channel: channel)
      send_message "#{user} agregó un [#{info['title']}](#{url}) a la lista de reproducción"
      render plain: valid_video(user, info['title'])
    else
      render plain: invalid_video(url, user)
    end
  end

  def clear_all
    Video.delete_all
  end

  private

  def verify_token
    if params[:token] == ENV['TOKEN']
      render plain: 'Error: Invalid token'
    end
  end
end
