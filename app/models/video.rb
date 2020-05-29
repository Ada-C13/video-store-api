class Video < ApplicationRecord
    has_many :rentals

    validates :title, presence: true
    validates :overview, presence: true
    validates :release_date, presence: true
    validates :total_inventory, presence: true
    validates :available_inventory, presence: true

    def decrease_inventory
      #video = Video.find_by(id: video_id)
      self.available_inventory -= 1
      self.save
    end

    def increase_inventory
        self.available_inventory += 1
        self.save
      end
end
