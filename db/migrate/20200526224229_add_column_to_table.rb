class AddColumnToTable < ActiveRecord::Migration[6.0]
  def change
    add_column :rentals, :customers_id, :string
  end
end
