class Imgur
  IMGUR_URL = 'https://api.imgur.com/3/image'.freeze
  IMGUR_CLIENT_ID = 'ae6353455c3635c'.freeze

  def self.post(encorded_image)
    response = RestClient.post(IMGUR_URL, { image: encorded_image, type: 'base64' },
                             { Authorization: "Client-ID #{IMGUR_CLIENT_ID}"})
    return nil unless response.code == 200

    json = JSON.parse(response)
    json['data']['link']
  end
end
