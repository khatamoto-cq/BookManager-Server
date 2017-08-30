class Book < ApplicationRecord
  IMAGUR_URL = 'https://api.imgur.com/3/image'.freeze
  IMGUR_CLIENT_ID = 'ae6353455c3635c'.freeze

  attr_accessor :image_data
  belongs_to :user
  validates :name, presence: true
  validates :price, presence: true, numericality: { only_integer: true }
  validates :purchase_date, date: true, allow_blank: true

  before_save :upload_image

  def upload_image
    return if image_data.nil?
    self.image_url = post(image_data)
  end

  private
    def post(encorded_image)
      response = RestClient.post(IMAGUR_URL, { image: encorded_image, type: 'base64' },
                               { Authorization: "Client-ID #{IMGUR_CLIENT_ID}"})
      return nil unless response.code == 200

      json = JSON.parse(response)
      return json['data']['link']
    end
end
