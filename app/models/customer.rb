class Customer < ApplicationRecord
  validates :name, presence: true
  validates :videos_checked_out_count, presence: true

  has_many :rentals, dependent: :destroy
  has_many :videos, :through => :rentals
end

