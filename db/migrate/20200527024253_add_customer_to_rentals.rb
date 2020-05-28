class AddCustomerToRentals < ActiveRecord::Migration[6.0]
  def change
    add_reference :rentals, :customer, index: true
    add_foreign_key :rentals, :customers
  end
end
