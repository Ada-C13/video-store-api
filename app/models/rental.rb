class Rental < ApplicationRecord
  belongs_to: :video
  belongs_to: :customers, counter_cache: true
end
