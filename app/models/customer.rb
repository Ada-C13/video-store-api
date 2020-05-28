class Customer < ApplicationRecord
  has_many :rentals
  has_many :videos, through: :rentals
  validates :name, :address, :city, :state, :postal_code, :phone, presence: true

  def increase_videos_checked_out_count
    self.videos_checked_out_count += 1
    self.save
  end
end
