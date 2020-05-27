class Video < ApplicationRecord
  validates :total_inventory, :release_date, :available_inventory, :overview, presence: true
  validates :title, uniqueness:{scope: :release_date}, presence: true
  validates :available_inventory, numericality: {greater_than_or_equal_to: 0, only_integer: true }
  has_many :rentals, dependent: :nullify
  has_many :customers, through: :rentals

  
end
