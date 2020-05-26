class MovieIDtoRental < ActiveRecord::Migration[6.0]
  def change
    add_reference :rentals, :videos, foreign_key: true
  end
end
