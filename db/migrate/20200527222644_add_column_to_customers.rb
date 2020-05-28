class AddColumnToCustomers < ActiveRecord::Migration[6.0]
  def change
    add_column :customers, :name, :string 
    add_column :customers, :registered_at, :string
    add_column :customers, :address, :string
    add_column :customers, :city, :string
    add_column :customers, :state, :string
    add_column :customers, :postal_code, :string
    add_column :customers, :phone, :string
  end
end
