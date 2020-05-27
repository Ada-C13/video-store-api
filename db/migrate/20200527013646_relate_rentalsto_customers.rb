class RelateRentalstoCustomers < ActiveRecord::Migration[6.0]
  def change
    remove_column :rentals, :customer_id
    add_reference :rentals, :customer, index: true
  end
end
