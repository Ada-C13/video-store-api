class RentalsColumns < ActiveRecord::Migration[6.0]
  def change
    add_column :rentals, :checkout_date, :date
    add_column :rentals, :due_date, :date
  end
end
