require "test_helper"

describe RentalsController do

  def check_response(expected_type:, expected_status: :success)
    must_respond_with expected_status
    expect(response.header['Content-Type']).must_include 'json'

    body = JSON.parse(response.body)
    expect(body).must_be_kind_of expected_type
    # pp body
    return body
  end

  describe "create" do
    let(:rental_data) {
      {
        video_id: videos(:frozen).id,
        customer_id: customers(:nataliya).id
      }
    }

    it "can create a rental" do
      expect{post rentals_path, params: rental_data}.must_differ "Rental.count", 1
      check_response(expected_type: Hash)
    end

    it "will return JSON with the following keys: customer_id, video_id, due_date, videos_checked_out_count, available_inventory" do

    end

    it "increase the customer's videos_checked_out_count by one" do
      expect(customers(:nataliya).videos_checked_out_count).must_equal 6
      
      # post rentals_path, params: rental_data
      # expect(customers(:nataliya).videos_checked_out_count).must_equal 7
    end

    it "decrease the video's available_inventory by one" do
    end

    it "will respond with 404: Not Found if the customer does not exist" do
      rental_data[:customer_id] = -1
      expect{post rentals_path, params: rental_data}.wont_change "Rental.count", 1
      body = check_response(expected_type: Hash, expected_status: :not_found)
      expect(body["errors"].keys).must_include "customer"
    end

    it "will respond with 404: Not Found if the video does not exist" do
      rental_data[:video_id] = -1
      expect{post rentals_path, params: rental_data}.wont_change "Rental.count", 1
      body = check_response(expected_type: Hash, expected_status: :not_found)
      expect(body["errors"].keys).must_include "video"
    end

    it "will respond with 400: Bad Request if the video does not have any available inventory before check out" do
      rental_data = {
        video_id: videos(:maleficent).id,
        customer_id: customers(:nataliya).id
      }
      expect{post rentals_path, params: rental_data}.wont_change "Rental.count", 1
      body = check_response(expected_type: Hash, expected_status: :bad_request)
      expect(body["errors"]).must_equal ["No available copies of the video available"]
    end

    it "will respond with 404: Not Found if the customer is already renting this video title" do
      post rentals_path, params: rental_data
      expect{post rentals_path, params: rental_data}.wont_change "Rental.count", 1
      body = check_response(expected_type: Hash, expected_status: :not_found)
      expect(body["errors"].keys).must_include "video_id"
    end
  end

  describe "check-in" do
    let(:rental_data) {
      {
        video_id: videos(:moana).id,
        customer_id: customers(:nataliya).id
      }
    }
    
    it "will destroy the instance of rental" do
      rental = Rental.find_by(video_id: rental_data[:video_id], customer_id: rental_data[:customer_id])
      expect{post check_in_path, params: rental_data}.must_differ "Rental.count", -1
      
      
    end

    it "will decrease the customer's videos_checked_out_count by one" do
    end

    it "increase the video's available_inventory by one" do

    end

    it "will return JSON with the following keys: customer_id, video_id, videos_checked_out_count, available_inventory" do
    
    end

    it "it will return 404: Not Found if the customer does not exist" do
    end

    it "404: Not Found if the video does not exist" do
    end
  end
end
