class AddReturnedColumnWithDate < ActiveRecord::Migration[6.0]
  def change
    add_column :rentals, :returned_on, :datetime
  end
end
