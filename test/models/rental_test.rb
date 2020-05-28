require "test_helper"

describe Rental do
  it "increment_videos_checked_out_count & decrement_available_inventory" do
  # Act
  customer = customers(:shelley)
  video = videos(:frozen)
  rental = Rental.create!(customer_id: customer.id, video_id: video.id)
  # Assert
  customer.reload
  video.reload
  expect(customer.videos_checked_out_count).must_equal 1
  expect(video.available_inventory).must_equal 19
  end

end
