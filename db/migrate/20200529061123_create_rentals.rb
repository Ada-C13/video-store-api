class CreateRentals < ActiveRecord::Migration[6.0]
  def change
    create_table :rentals do |t|
      t.date :check_out_date
      t.date :check_in_date
      t.date :due_date

      t.timestamps
    end
  end
end
