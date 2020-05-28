class Customer < ApplicationRecord
  has_many :rentals

  validates :id, presence: true
  validates :name, presence: true
  validates :registered_at, presence: true
  validates :postal_code, presence: true
  validates :phone, presence: true
  validates :videos_checked_out_count, presence: true

  def increment_checked_out_count
    self.videos_checked_out_count += 1
    self.save
  end

  def decrement_checked_out_count
    self.videos_checked_out_count -= 1
    self.save
  end
end
