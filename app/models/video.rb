class Video < ApplicationRecord
  has_many :rentals, dependent: :destroy     

  validates :title, presence: true
  validates :release_date, presence: true
  validates :overview, presence: true
  validates :available_inventory, presence: true, numericality: { only_integer: true }
  validates :total_inventory, presence:true, numericality: true
  
end
