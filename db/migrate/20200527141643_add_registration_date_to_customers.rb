class AddRegistrationDateToCustomers < ActiveRecord::Migration[6.0]
  def change
    add_column :customers, :registered_at, :timestamp
  end
end
