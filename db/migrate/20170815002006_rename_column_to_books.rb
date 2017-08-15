class RenameColumnToBooks < ActiveRecord::Migration[5.1]
  def change
    rename_column :books, :purchage_date, :purchase_date
  end
end
