class Video < ApplicationRecord
  has_many :rentals

  # def video_available 
  #   video = Video.find_by(id: )
  #   if video.available_inventory > 0 
  #     return true
  #   end 
  #   return false
  # end 
end
