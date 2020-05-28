class Customer < ApplicationRecord
  validates :name, :registered_at, :postal_code, :phone, presence: true

  has_many :rentals
  has_many :videos through: :rentals

  def add_videos_to_checked_out
    self.videos_checked_out_count += 1
    self.save
  end

  def remove_videos_from_checked_out
    self.videos_checked_out_count -= 1
    self.save
  end
