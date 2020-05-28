class CreateRentals < ActiveRecord::Migration[6.0]
  def change
    create_table :rentals do |t|
      t.date :check_in #just need date, time not a requirement
      t.date :check_out
      t.date :due_date
      t.belongs_to :customer
      t.belongs_to :video
      
      t.timestamps
    end
  end
end
