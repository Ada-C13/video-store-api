class Video < ApplicationRecord
  has_many :rentals
  has_many :customers, through: :rentals

  validates :title, presence: true
  validates :overview, presence: true
  validates :release_date, presence: true
  # To-DO: check against available
  validates :total_inventory, presence: true, numericality: { only_integer: true }

end
