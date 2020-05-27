class Video < ApplicationRecord
  has_many :rentals
  has_many :customers, through: :rentals
  validates :title, :overview, :total_inventory, :available_inventory, :release_date, presence: true
  validates :total_inventory, :available_inventory, numericality: { only_integer: true }
end
