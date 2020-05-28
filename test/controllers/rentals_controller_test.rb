require "test_helper"

describe RentalsController do
  # it "does a thing" do
  #   value(1+1).must_equal 2
  # end





  describe "check_in" do 
    let(:rental_data) {
      {
<<<<<<< HEAD
        customer_id: customers(:charli).id
=======
        customer_id: customers(:charli).id,
>>>>>>> 92d038741202c6046716d8286242efdce41caab8
        video_id: videos(:firstvideo).id
      }
    }

    before do
      post check_out_path, params: rental_data
<<<<<<< HEAD
  end

  it "will allow a video check in" do
    customer_video_count = customers(:charli).videos_checked_out_count
    video_inventory = videos(:firstvideo).available_inventory
  end
end
=======
    end

    it "will allow a video check in" do
      customer_video_count = customers(:charli).videos_checked_out_count
      video_inventory = videos(:firstvideo).available_inventory

      expect {
        post check_in path, params: rental_data
    }.must_differ "Rental.count", 0

    must_respond_with :success
    expect(Rental.all.first.check_in_date).must_equal Date.today

    customer = Customer.findP_by(id: rental_data[:customer_id])
    video = Video.find_by(id: rental_data[:video_id])

    expect(customer.videos_checked_out_count).must_respond_with customer_video_count
    expect(video.available_inventory).must_equal video_inventory
    end
  end # describe check-in end
    
end # describe RentalsController end
>>>>>>> 92d038741202c6046716d8286242efdce41caab8
