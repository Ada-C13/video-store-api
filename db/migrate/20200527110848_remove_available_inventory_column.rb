class RemoveAvailableInventoryColumn < ActiveRecord::Migration[6.0]
  def change
    remove_column :videos, :available_inventory
  end
end
