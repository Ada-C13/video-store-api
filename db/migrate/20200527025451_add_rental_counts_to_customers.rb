class AddRentalCountsToCustomers < ActiveRecord::Migration[6.0]
  def change
    change_table :customers do |t|
      t.integer :rentals_count, default: 0
    end
  end
end
