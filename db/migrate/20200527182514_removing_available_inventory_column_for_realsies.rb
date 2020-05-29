class RemovingAvailableInventoryColumnForRealsies < ActiveRecord::Migration[6.0]
  def change
    remove_column :videos, :available_inventory, :integer
  end
end
