class AddDefaultToNewReturnedColumn < ActiveRecord::Migration[6.0]
  def change
    change_column_default :rentals, :returned_on, nil 
  end
end
