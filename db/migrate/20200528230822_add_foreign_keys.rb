class AddForeignKeys < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :rentals, :videos
    add_foreign_key :rentals, :customers
  end
end
