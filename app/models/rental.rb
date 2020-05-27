class Rental < ApplicationRecord
  belongs_to: :video
  belongs_to: :customer, counter_cache: true
end
