class Customer < ApplicationRecord
  has_many :rentals
  has_many :videos, through: :rentals

  validates :name, :registered_at, :address, :city, :state, :postal_code, :phone, :videos_checked_out_count, presence: :true
  # validates :registered_at, presence: :true
  # validates :address, presence: :true
  # validates :city, presence: :true
  # validates :state, presence: :true
  # validates :postal_code, presence: :true
  # validates :phone, presence: :true
  # validates :videos_checked_out_count, presence: :true

  def self.increase_checked_out_count
    self.update(videos_checked_out_count += 1)
    self.save
  end

  def self.decrease_checked_out_count
    self.update(videos_checked_out_count -= 1)
    self.save
  end
end