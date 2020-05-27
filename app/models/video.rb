class Video < ApplicationRecord
  has_many :rentals
  has_many :customers

  validates :title, :release_date, :available_inventory, presence: true
end
