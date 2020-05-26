class CreateCustomers < ActiveRecord::Migration[6.0]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.string :phone
      t.string :postal_code
      t.datetime :registered_at

      t.timestamps
    end
  end
end
