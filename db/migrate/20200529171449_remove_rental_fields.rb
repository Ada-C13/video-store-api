class RemoveRentalFields < ActiveRecord::Migration[6.0]
  def change
    remove_column :rentals, :check_out_date
  end
end
