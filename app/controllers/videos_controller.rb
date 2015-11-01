class VideosController < InheritanceController
  def index
    render plain: 'videos'
  end
end
