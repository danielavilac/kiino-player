module ApplicationHelper
  def parse_youtube url
     regex = /(?:.be\/|\/watch\?v=|\/(?=p\/))([\w\/\-]+)/
     url.match(regex)[1]
  end
end
