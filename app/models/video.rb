class Video < ApplicationRecord
  validates :title, presence: true
  validates :available_inventory, presence: true
  
  has_many :rentals
  has_many :customers, :through => :rentals
end
