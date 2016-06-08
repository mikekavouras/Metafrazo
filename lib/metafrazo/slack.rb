require 'rest-client'
require 'json'

module Metafrazo
  class Slack
    def self.send_message(message, url)
      payload = {
        channel: '#metafrazo',
        username: 'Metafrazo',
        text: message,
        icon_emoji: 'ghost'
      }

      RestClient.post(url, payload.to_json, content_type: :json)
    end
  end
end
