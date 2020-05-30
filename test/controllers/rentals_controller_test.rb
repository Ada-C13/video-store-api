require "test_helper"

describe RentalsController do
  let(:customer_fixture) {customer(:customer_1)}
  let(:video_fixture) {video(:video_1)}
  let(:rental_fixture1){rental(:rental_1)}
  let(:not_avail_rental_fixture){rental(:rental_2)}
  let(:good_rental_data){
    {
    customer_id: customer_fixture.id,
    video_id: video_fixture.id
    }
  }
  let(:bad_rental_data1){
    {
    customer_id: "horse",
    video_id: 1
    }
  }
  let(:bad_rental_data2){
    {
    customer_id: 1,
    video_id: "horse"
    }
  }
  
  
  describe "checkout" do 
    it "good data: responds with success, created new rental" do
      expect {
        post check_out_path, params: good_rental_data
      }.must_differ 'Rental.count', 1 
      must_respond_with :created
    end
    it "good data: correct http response" do
      rental_attr = ["customer_id", "video_id", "due_date", "videos_checked_out_count", "available_inventory"]
      post check_out_path, params: good_rental_data
      body = JSON.parse(response.body)
      expect(response.header['Content-Type']).must_include 'json'
      expect(body.keys.sort).must_equal rental_attr.sort
    end
    it "bad_data: responds with not found when customer id bad" do
      post check_out_path, params: bad_rental_data1
      must_respond_with :not_found
    end
    it "bad_data: responds with not found when video id bad" do
      post check_out_path, params: bad_rental_data2
      must_respond_with :not_found
    end
    it "responds with bad_request when video not available" do
      post check_in_path, params: not_avail_rental_fixture.as_json(only: [:customer_id, :video_id])
    end
    
  end

  describe "checkin" do
    it "responds with success when passed in valid params" do
      post check_in_path, params: rental_fixture1.as_json(only: [:customer_id, :video_id])
      must_respond_with :ok
    end
    it "good data: correct http response, expected data" do
      rental_attr = ["customer_id", "video_id", "videos_checked_out_count", "available_inventory"]
      post check_in_path, params: rental_fixture1.as_json(only: [:customer_id, :video_id])
      body = JSON.parse(response.body)
      expect(response.header['Content-Type']).must_include 'json'
      expect(body.keys.sort).must_equal rental_attr.sort
    end
    it "responds with bad request for bad customer data" do 
      post check_in_path, params: bad_rental_data1
      must_respond_with :not_found
    end
    it "responds with bad request for bad video data" do 
      post check_in_path, params: bad_rental_data2
      must_respond_with :not_found
    end

  end
end
