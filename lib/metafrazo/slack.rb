require 'rest-client'
require 'json'

module Metafrazo
  class Slack
    def self.send_message(message, url)
      payload = {
        channel: '#metafrazo',
        username: 'Metafrazo',
        text: message,
        icon_url: 'https://avatars2.githubusercontent.com/u/19434500?v=3&s=400'
      }

      RestClient.post(url, payload.to_json, content_type: :json)
    end
  end
end
