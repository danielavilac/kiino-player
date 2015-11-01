class Api::V1::VideosController < ApplicationController
  include ApplicationHelper
  before_action :verify_token

  def push
    user = params[:user_name]
    team = params[:team_name]
    channel = params[:channel_name]
    text = params[:text]
    url = text.split(' ').first

    Video.create(
        url: url,
        user: user,
        team: team,
        channel: channel
      )
    render plain:
      "El video #{parse_youtube url} se ha añadido a la lista de reproducción"
  end

  private

  def verify_token
    if params[:token] == ENV['TOKEN']
      render plain: 'Error: Invalid token'
    end
  end
end