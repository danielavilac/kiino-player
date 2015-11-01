class Video < ActiveRecord::Base
  include ApplicationHelper
  def youtube_id
    parse_youtube(self.url)
  end
end
