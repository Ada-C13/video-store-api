class AddDefaultToReturnedColumn < ActiveRecord::Migration[6.0]
  def change
    change_column_default(:rentals, :returned, false)
  end
end
