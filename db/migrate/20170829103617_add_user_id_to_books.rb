class AddUserIdToBooks < ActiveRecord::Migration[5.1]
  def change
    add_reference :books, :users, index: true, foreign_key: true
  end
end
