class ChangeDetailToBooks < ActiveRecord::Migration[5.1]
  def change
    change_column :books, :name, :string, null: false, limit: 255
    change_column :books, :price, :integer, null: false
    change_column :books, :image_url, :string, limit: 255
    change_column :books, :user_id, :integer, index: true
  end
end
