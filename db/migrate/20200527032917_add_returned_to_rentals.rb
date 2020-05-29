class AddReturnedToRentals < ActiveRecord::Migration[6.0]
  def change
    add_column :rentals, :returned, :boolean
  end
end
