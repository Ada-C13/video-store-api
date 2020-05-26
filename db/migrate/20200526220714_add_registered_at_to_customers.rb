class AddRegisteredAtToCustomers < ActiveRecord::Migration[6.0]
  def change
    add_column :customers, :registered_at, :string
  end
end
