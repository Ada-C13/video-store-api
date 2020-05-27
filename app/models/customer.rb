class Customer < ApplicationRecord
  has_many :rentals
  has_many :videos, through: :rentals
  validates :name, :address, :city, :state, :postal_code, :phone, presence: true  

  def videos_checked_out_count
    return videos.where("returned_on".nil?).count
  end

end
