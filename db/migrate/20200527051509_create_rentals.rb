class CreateRentals < ActiveRecord::Migration[6.0]
  def change
    create_table :rentals do |t|
      t.date :due_date
      t.date :checkin_date
      t.date :checkout_date
      


      t.timestamps
    end
  end
end
