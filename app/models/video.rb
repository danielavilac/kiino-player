class Video < ActiveRecord::Base
  include ApplicationHelper
  def youtube_id
    parse_youtube(self.url)[1]
  end

  def valid_url?
    valid_youtube_url?(self.url)
  end

  def info
    youtube_information(self.url)
  end
end
