require "test_helper"

describe RentalsController do

  REQUIRED_ATTRS = ["customer_id", "video_id", "due_date"].sort

  describe "check out" do
    let(:check_out_data) {
      {
        rental: {
          customer_id: customers(:customer_one).id,
          video_id: videos(:fake_vid).id,
        }
      }
    }

    it "creates a rental checkout" do
      expect {
        post check_out_path, params: check_out_data
      }.must_differ "Rental.count", 1

      # expect(customers(:customer_one).videos_checked_out_count).must_equal 1
      # expect(videos(:fake_vid).available_inventory).must_equal 8

      must_respond_with :ok

      body = JSON.parse(response.body)
      expect(body).must_be_instance_of Hash
      expect(body.keys.sort).must_equal REQUIRED_ATTRS
    end

    it "will respond with bad_request if the customer is not found" do 
      check_out_data[:rental][:customer_id] = nil

      expect {
        post check_out_path, params: check_out_data
      }.wont_change "Rental.count"

      must_respond_with :not_found 

      expect(response.header['Content-Type']).must_include 'json'
      body = JSON.parse(response.body)
      expect(body["errors"]).must_equal 'Customer does not exist.'
    end

    it "will respond with bad_request if the video is not found" do 
      check_out_data[:rental][:video_id] = nil

      expect {
        post check_out_path, params: check_out_data
      }.wont_change "Rental.count"

      must_respond_with :not_found 

      expect(response.header['Content-Type']).must_include 'json'
      body = JSON.parse(response.body)
      expect(body["errors"]).must_equal 'Video does not exist.'
    end

    it "will respond with ok false if the video is not in stock" do 
      check_out_data[:rental][:video_id] = videos(:none_avail_vid).id

      expect {
        post check_out_path, params: check_out_data
      }.wont_change "Rental.count"

      must_respond_with :bad_request 

      expect(response.header['Content-Type']).must_include 'json'
      body = JSON.parse(response.body)
      expect(body["errors"]).must_equal 'This video is out of stock.'
    end
  end

  describe "check in" do

  end
end
