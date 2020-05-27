class Video < ApplicationRecord
  validates :title, presence: true
  validates :release_date, presence: true
  validates :total_inventory, presence: true, numericality: {only_integer: true, greater_than: -1 }
  validates :available_inventory, presence: true, numericality: {only_integer: true, greater_than: -1 }
  validates :overview, presence: true
  
end
