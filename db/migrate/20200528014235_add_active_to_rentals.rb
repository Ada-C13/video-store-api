class AddActiveToRentals < ActiveRecord::Migration[6.0]
  def change
    add_column :rentals, :active, :boolean
  end
end
