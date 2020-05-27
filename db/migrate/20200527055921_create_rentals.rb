class CreateRentals < ActiveRecord::Migration[6.0]
  def change
    create_table :rentals do |t|
      t.string :title
      t.string :name
      t.string :postal_code
      t.datetime :checkout_date
      t.datetime :due_date

      t.timestamps
    end
  end
end
