class Video < ApplicationRecord
  # validates :title, presence: true
  # validates :overview, presence: true
  # validates :release_date, presence: true


  has_many :rentals, dependent: :nullify
  has_many :customers, through: :rentals
end
