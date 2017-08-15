class BookSerializer < ActiveModel::Serializer
  attributes :id, :image_url, :name, :price, :purchase_date
end
