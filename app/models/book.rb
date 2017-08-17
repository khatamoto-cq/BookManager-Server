require 'base64'

class Book < ApplicationRecord
  attr_accessor :image_data

  validates :name, presence: true
  validates :price, presence: true, numericality: { only_integer: true }
  validates :purchase_date, date: true

  before_save :decode_image

  def decode_image
    #debugger
    return if image_data.nil?
    self.image_url = "http://caraquri.com/hoge.jpg"
    file = Base64.decode64(self.image_data)
    File.open("#{Rails.root}/tmp/hello.jpg", 'wb') do |file|
      file.write(file)
    end
  end
end
