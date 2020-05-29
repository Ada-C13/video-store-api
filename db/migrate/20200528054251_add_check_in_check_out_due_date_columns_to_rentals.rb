class AddCheckInCheckOutDueDateColumnsToRentals < ActiveRecord::Migration[6.0]
  def change
    add_column :rentals, :check_in_date, :string
    add_column :rentals, :check_out_date, :string
    add_column :rentals, :due_date, :string
  end
end
