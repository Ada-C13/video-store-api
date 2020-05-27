class CreateCustomers < ActiveRecord::Migration[6.0]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.string :postal_code
      t.integer :videos_checked_out_count 
      t.string :phone

      t.timestamps
    end
  end
end
