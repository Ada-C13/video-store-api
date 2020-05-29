class ChangeTypeForDatesRentalsTable < ActiveRecord::Migration[6.0]
  def change
    remove_column :rentals, :check_in_date
    add_column :rentals, :check_in_date, :datetime

    remove_column :rentals, :check_out_date
    add_column :rentals, :check_out_date, :datetime

 end
end
