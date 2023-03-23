class AddValueToParts < ActiveRecord::Migration[7.0]
  def change
    add_column :parts, :value, :decimal, precision: 10, scale: 2
  end
end
