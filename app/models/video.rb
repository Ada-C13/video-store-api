class Video < ApplicationRecord
  validates :total_inventory, :release_date, presence: true
  validates :title, uniqueness:{scope: :release_date}, presence: true
  has_many :rentals, dependent: :nullify
  has_many :customers, through: :rentals

  
end
