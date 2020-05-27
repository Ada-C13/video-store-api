class Rental < ApplicationRecord
  belongs_to :video
  belongs_to :customer, counter_cache: :videos_checked_out_count
end
