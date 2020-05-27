class RemovedReturnedColumn < ActiveRecord::Migration[6.0]
  def change
    remove_column :rentals, :returned
  end
end
