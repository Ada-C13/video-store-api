require "test_helper"

describe RentalsController do
  # it "does a thing" do
  #   value(1+1).must_equal 2
  # end

  describe "index" do
    it "gets index" do

    get rentals_path

    must_respond_with :success
    expect(response.header['Content-Type']).must_include 'json'
  end
end

  describe "check_out" do
    let(:rental_data) {
      {
          customer_id: customers(:charli).id,
          videos_id: videos(:firstvideo).id
      }
    }

    it "creates a rental" do
      expect { post check_out_path, params: rental_data }.must_differ "Rental.count", 1
      must_respond_with :created
    end
  end

  describe "check_in" do 
    let(:rental_data) {
      {
        customer_id: customers(:charli).id,
        videos_id: videos(:firstvideo).id
      }
    }

    before do
      post check_out_path, params: rental_data
    end

    it "will allow a video check in" do
      customer_video_count = customers(:charli).videos_checked_out_count
      video_inventory = videos(:firstvideo).available_inventory

      expect {
        post check_in_path, params: rental_data
    }.must_differ "Rental.count", 0

    must_respond_with :success
    expect(Rental.all.first.check_in_date).must_equal Date.today

    customer = Customer.find_by(id: rental_data[:customer_id])
    video = Video.find_by(id: rental_data[:videos_id])

    expect(customer.videos_checked_out_count).must_equal customer_video_count
    expect(video.available_inventory).must_equal video_inventory
    end
  end # describe check-in end
    
end # describe RentalsController end
