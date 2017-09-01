class Book < ApplicationRecord
  attr_accessor :image_data

  belongs_to :user
  validates :name, presence: true
  validates :price, presence: true, numericality: { only_integer: true }
  validates :purchase_date, date: true, allow_blank: true

  before_save :upload_image

  def upload_image
    return if image_data.nil?
    self.image_url = Imgur.post(image_data)
  end
end
