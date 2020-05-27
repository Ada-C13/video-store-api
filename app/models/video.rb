class Video < ApplicationRecord
  has_many :rentals
  has_many :customers, :through => :rentals 
  
  validates :title, presence: true, uniqueness: true
  validates :release_date, presence: true
  validates :total_inventory, presence: true
  validates :available_inventory, presence: true
  validates :overview, presence: true

  # def video_available 
  #   video = Video.find_by(id: )
  #   if video.available_inventory > 0 
  #     return true
  #   end 
  #   return false
  # end 
end
