require "test_helper"

describe RentalsController do  
  REQUIRED_RENTALS_FIELDS = ["id", "customer_id", "video_id", "checked_in_date", "checked_out_date", "created_at", "due_date", "updated_at"].sort

  def check_response(expected_type:, expected_status: :success)
    must_respond_with expected_status
    expect(response.header["Content-Type"]).must_include "json"
          
    body = JSON.parse(response.body)
    expect(body).must_be_kind_of expected_type
    return body
  end

  describe "index" do 
    it "responds with JSON and success" do
      get rentals_path

      check_response(expected_type: Array)
    end

    it "responds with an array of rentals hashes" do
      get rentals_path

      body = check_response(expected_type: Array)

      body.each do |rental|
        expect(rental).must_be_instance_of Hash

        expect(rental.keys.sort).must_equal REQUIRED_RENTALS_FIELDS
      end
    end

    it "will respond with an empty array when there are no rentals" do
      Rental.destroy_all

      get rentals_path

      body = check_response(expected_type: Array)
      expect(body).must_equal []
    end
  end

  describe "check out" do  
    let(:rental_data) {
    {
    video_id: videos(:video_1).id,
    customer_id: customers(:customer_1).id
    }
    }
    
    it "will allow customer to check out a video" do
      expect {
      post check_out_path, params: rental_data
      }.must_differ "Rental.count", 1
      
      must_respond_with :success
    end

    it "won't allow customer to checkout if video does not exist" do
      rental_data[:video_id] = nil
      
      expect {
      post check_out_path, params: rental_data
      }.must_differ "Rental.count", 0
      
      must_respond_with :not_found
    end

    it "won't allow checkout if there is no customer" do
      rental_data[:customer_id] = nil
      
      expect {
        post check_out_path, params: rental_data
      }.must_differ "Rental.count", 0
      must_respond_with :not_found
    end
  end


  describe "check in" do  
    let(:rental_data) {
    {
    video_id: videos(:video_1).id,
    customer_id: customers(:customer_1).id
    }
    }
    
    it "will allow customer to check_in a video" do
      post check_in_path, params: rental_data
      must_respond_with :success
      post check_in_path, params: rental_data
      must_respond_with :not_found
    end

    it "won't allow customer to check_in a video that has already been checked-in" do
      post check_in_path, params: { 
        video_id: videos(:video_2).id,
        customer_id: customers(:customer_1).id
        }
      must_respond_with :not_found
    end
    


    it "won't allow customer to check_in if video does not exist" do
      rental_data[:video_id] = nil
      post check_in_path, params: rental_data
      must_respond_with :not_found
    end

    it "won't allow check_in if there is no customer" do
      rental_data[:customer_id] = nil
      post check_in_path, params: rental_data
      must_respond_with :not_found
    end

  end

end
