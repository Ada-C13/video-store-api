class CreateCustomers < ActiveRecord::Migration[6.0]
  def change
    create_table :customers do |t|
      t.string :name
      t.string : address
      t.string :city
      t.string :state
      t.integer :postal_code
      t.string videos_checked_out_count :phone

      t.timestamps
    end
  end
end
