class Video < ApplicationRecord
  has_many :rentals , dependent: :destroy
  validates :title, :overview, :release_date, :total_inventory, :available_inventory, presence: true
end
