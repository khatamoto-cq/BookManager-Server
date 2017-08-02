class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.string :image_url
      t.string :name
      t.integer :price
      t.datetime :purchage_date

      t.timestamps
    end
  end
end
