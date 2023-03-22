class AddColumnBookIdAParts < ActiveRecord::Migration[7.0]
  def change
    add_column :parts, :book_id, :integer
  end
end
