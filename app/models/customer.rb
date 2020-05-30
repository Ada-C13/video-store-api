class Customer < ApplicationRecord
  has_many :rentals
  has_many :videos, through: :rentals, dependent: :nullify

  validates :name, presence: true
  validates :registered_at, presence: true
  validates :phone, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :postal_code, presence: true
  validates :videos_checked_out_count, presence: true

  def checked_out_video
    self.videos_checked_out_count += 1
    self.save
    return self
  end

  def checked_in_video
    self.videos_checked_out_count -= 1
    self.save
    return self
  end

end


