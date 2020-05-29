require "test_helper"

describe RentalsController do

  describe "index" do
    it "gets index" do

    get rentals_path

    must_respond_with :success
    expect(response.header['Content-Type']).must_include 'json'
    end
  end # describe index end

  describe "check_out" do
    let(:rental_data) {
      {
          customer_id: customers(:charli).id,
          videos_id: videos(:firstvideo).id
      }
    }

    it "creates a rental" do
      expect { post check_out_path, params: rental_data }.must_differ "Rental.count", 1
      must_respond_with :ok
    end

    it "will not create a check_out if customer does not exist" do 
      rental_data[:customer_id] = nil
      
      expect {
        post check_out_path, params: rental_data
      }.must_differ "Rental.count", 0

     must_respond_with :not_found
    end

    it "will not create a check_out if video does not exist" do 
      rental_data[:videos_id] = nil
      
      expect {
        post check_out_path, params: rental_data
      }.must_differ "Rental.count", 0

     must_respond_with :not_found
    end
  end # describe check-out end
  

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
    
    it "will not allow check-in for nonexistent video" do
      rental_data[:videos_id] = nil
      
      expect {
        post check_out_path, params: rental_data
      }.must_differ "Rental.count", 0

     must_respond_with :not_found
    end

    it "will not allow check-in for nonexistent customer" do
      rental_data[:customer_id] = nil
      
      expect {
        post check_out_path, params: rental_data
      }.must_differ "Rental.count", 0

     must_respond_with :not_found
    end

  end # describe check-in end
    
end # describe RentalsController end
