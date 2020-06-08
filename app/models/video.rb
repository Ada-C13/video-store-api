class Video < ApplicationRecord
  has_many :rentals
  has_many :customers, through: :rentals
  
  validates :title, presence: :true
  validates :overview, presence: :true
  validates :release_date, presence: :true
  validates :total_inventory, presence: :true
  validates :available_inventory, presence: :true

  def self.decrease_available_inventory
    self.available_inventory -= 1
    self.save
  end

  def self.has_available_inventory?
    return self.available_inventory > 0
  end
end
