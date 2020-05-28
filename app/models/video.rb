class Video < ApplicationRecord
  validates :title, presence: true
  validates :available_inventory, presence: true
  
  has_many :rentals, dependent: :destroy
  has_many :customers, :through => :rentals
end
