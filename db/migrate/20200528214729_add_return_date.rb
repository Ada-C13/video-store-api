class AddReturnDate < ActiveRecord::Migration[6.0]
  def change
    add_column :rentals, :return_date, :date
  end
end
