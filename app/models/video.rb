class Video < ApplicationRecord
  has_many :rentals
  has_many :customers

  validates :title, :release_date, :available_inventory, presence: true


  def decrease_inventory
    self.available_inventory -= 1
    self.save
  end

  def increase_inventory
    self.available_inventory += 1
    self.save
  end

  def available
    return self.available_inventory > 0
  end

end
