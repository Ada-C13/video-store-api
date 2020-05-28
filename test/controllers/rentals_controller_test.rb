require "test_helper"

describe RentalsController do
  # it "does a thing" do
  #   value(1+1).must_equal 2
  # end





  describe "check_in" do 
    let(:rental_data) {
      {
        customer_id: customers(:charli).id
        video_id: videos(:firstvideo).id
      }
    }

    before do
      post check_out_path, params: rental_data
  end

  it "will allow a video check in" do
    customer_video_count = customers(:charli).videos_checked_out_count
    video_inventory = videos(:firstvideo).available_inventory
  end
end
