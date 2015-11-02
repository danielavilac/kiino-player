module ApplicationHelper
  def parse_youtube url
     regex = /^(?:https?:\/\/)?(?:www\.)?youtu(?:\.be|be\.com)\/(?:watch\?v=)?([\w-]{10,})/
     url.match(regex)
  end

  def valid_youtube_url? url
     !parse_youtube(url).nil?
  end

  def valid_video user
    [
      "Bien #{user}, se agregó la canción a la fila",
      "¡Listo!, tu canción es la número #{Video.count} en la fila",
      "¡Ya quedó!, sólo espero que no sea reggaeton",
      "Listo #{user}, ya la agregué a la lista, lástima que sólo soy un pedazo de software y no puedo oír la canción",
      "Tu canción está en la lista, faltan #{Video.count} canciones para la tuya",
      "Listo, ya me estoy cansando de este tipo de canciones",
      "Seguro que quieres poner eso #{user}, ¿bueno quién soy yo para juzgarte?"
    ].sample
  end

  def invalid_video url, user
    [
      "El URL del video no es válido",
      "¿por quién me tomas? Ese no es un URL válido",
      "#{user}, no tengo tiempo para bromas, dame un URL válido",
      "¡Vamos #{user}! ¿seguro que es un URL de Youtube?",
      "Hay veces que quisiera renunciar, dame un URL de Youtube válido",
      "#{user} ¿qué tan difícil es sacar un URL de Youtube?",
      "#{user} ¿Es neta? dame el URL bien por favor",
    ].sample
  end

  def youtube_information yt_url
    host = "www.youtube.com"
    params = "/oembed?url=#{yt_url}&format=json"
    response = Net::HTTP.get_response(host, params)
    JSON.parse(response.body)
  end

  def send_message message, status='music'
    webhook_url = "https://hooks.slack.com/services/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"
    notifier = Slack::Notifier.new webhook_url,
      channel: '#music',
      username: 'Bitlab Music',
      icon_emoji: ":bitlab_#{status}:"
    notifier.ping message if ENV['messages_enabled'] == 'true'
  end

  def now_playing video
    if (Video.count > 0)
      if (Video.count > 4)
        reminding = "\n*Videos en fila:* #{Video.count}"
      else
        reminding = "\n:warning: Sólo hay #{Video.count} videos en la fila, agregar vidos con `/music` :warning:"
      end
      send_message("*Ahora suena:* #{video.info['title']}" +
        "\n*Agregada por:* #{video.user}" + reminding)
    else
      send_message(":warning: No hay más videos en la fila :dizzy_face:, agrega más videos con `/music` :warning:", "danger")
    end
  end
end
