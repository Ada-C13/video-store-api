class Customer < ApplicationRecord
  has_many :rentals
  has_many :videos, through: :rentals

  def update_checkout(count)
    self.videos_checked_out_count += count
    self.save
  end
end
