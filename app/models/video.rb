class Video < ApplicationRecord
  validates :title, :release_date, :available_inventory, presence: true
  has_many :rentals
  has_many :customers, through: :rentals, dependent: :nullify
end
