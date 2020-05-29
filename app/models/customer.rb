class Customer < ApplicationRecord

  has_many :rentals
  has_many :videos, through: :rentals

  validates :name, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :postal_code, presence: true
  validates :phone, presence: true
  validates :registered_at, presence: true

  def add_checked_out 
    self.videos_checked_out_count += 1
    save
  end

  def remove_checked_out 
    self.videos_checked_out_count -= 1
    save

  end
end
