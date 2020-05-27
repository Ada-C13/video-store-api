class RelateTables < ActiveRecord::Migration[6.0]
  def change
    add_reference :rentals, :customers, foreign_key: true
    add_reference :rentals, :videos, foreign_key: true
  end
end
