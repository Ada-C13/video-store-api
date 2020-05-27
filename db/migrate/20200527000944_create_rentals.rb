class CreateRentals < ActiveRecord::Migration[6.0]
  def change
    create_table :rentals do |t|
      t.references :video, index: true
      t.references :customer, index: true

      t.timestamps
    end
  end
end
