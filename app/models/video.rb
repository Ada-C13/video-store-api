class Video < ApplicationRecord
  validates :title, release_date:, available_inventory:, presence: true
  has_many :customers, dependent: :nullify
end
