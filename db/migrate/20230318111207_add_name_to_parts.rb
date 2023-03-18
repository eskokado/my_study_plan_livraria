class AddNameToParts < ActiveRecord::Migration[7.0]
  def change
    add_column :parts, :name, :string
  end
end
