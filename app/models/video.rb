class Video < ApplicationRecord
  validates :title, presence: true
  validates :release_date, presence: true
  validates :total_inventory, presence: true
  validates :available_inventory, presence: true
  validates :overview, presence: true
  
end
