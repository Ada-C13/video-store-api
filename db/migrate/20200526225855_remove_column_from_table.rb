class RemoveColumnFromTable < ActiveRecord::Migration[6.0]
  def change
    remove_column :rentals, :customers_id, :string
  end
end
