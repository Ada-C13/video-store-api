class Customer < ApplicationRecord
  validates :name, :registered_at, :postal_code, :phone, presence: true

  # set to nullify - then when a customer is deleted, the videos associated with that 
  # customerId will not be deleted
  has_many :rentals, dependent: :nullify
  has_many :videos, through: :rentals

  def add_videos_to_checked_out
    self.videos_checked_out_count += 1
    self.save
  end

  def remove_videos_from_checked_out
    self.videos_checked_out_count -= 1
    self.save
  end

end
