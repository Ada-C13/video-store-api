require "test_helper"
require "pry"

describe RentalsController do
  describe "index" do
    RENTAL_FIELDS = ["id","check_in_date","check_out_date","due_date","video_id","customer_id"].sort

    it "must get index" do
      get rentals_path
      must_respond_with :success
      expect(response.header["Content-Type"]).must_include "json"
    end

    it "responds with JSON and success" do
      get rentals_path

      expect(response.header["Content-Type"]).must_include "json"
      must_respond_with :ok
    end

    it "will return all proper field for all of rentals " do
      # Act
      get rentals_path

      # getting the body. JSON.parse: command take that json turn into a ruby array or hash.
      body = JSON.parse(response.body)
      #Assert
      expect(body).must_be_instance_of Array
      body.each do |rental|
        expect(rental).must_be_instance_of Hash
        expect(rental.keys.sort).must_equal RENTAL_FIELDS
      end
    end

    it "returns an empty array if not rentals exist" do
      Rental.destroy_all
      # Act
      get rentals_path

      # getting the body. JSON.parse: command take that json turn into a ruby array or hash.
      body = JSON.parse(response.body)
      #Assert
      expect(body).must_be_instance_of Array
      expect(body.length).must_equal 0
    end
  end

  describe "check out" do 
    let(:rental_data) {
      {
        video_id: videos(:video_1).id,
        customer_id: customers(:customer_1).id
      }
    }

    it "can allow check out" do
      expect {
        post check_out_path, params: rental_data
      }.must_differ "Rental.count", 1

      must_respond_with :success
    end

    it "prevents checkout if customer does not exist" do
      rental_data[:customer_id] = nil

      expect {
        post check_out_path, params: rental_data
      }.must_differ "Rental.count", 0

      must_respond_with :not_found
    end

    it "prevents checkout if video does not exist" do
      rental_data[:video_id] = nil

      expect {
        post check_out_path, params: rental_data
      }.must_differ "Rental.count", 0

      must_respond_with :not_found
    end

    it "prevents checkout if video is not available" do
      rental_data[:video_id] = videos(:video_2).id

      expect {
        post check_out_path, params: rental_data
      }.must_differ "Rental.count", 0

      must_respond_with :bad_request
    end
  end

  describe "check in" do 
    let(:rental_data) {
      {
        video_id: videos(:video_1).id,
        customer_id: customers(:customer_1).id
      }
    }

    before do 
      post check_out_path, params: rental_data
    end

    it "can allow check in" do
      expect {
        post check_in_path, params: rental_data
      }.must_differ "Rental.count", 0

      must_respond_with :success
      expect(Rental.all.first.check_in_date).must_equal Date.today
    end

    it "prevents check in customer has not made rental" do
      rental_data[:customer_id] = nil

      expect {
        post check_in_path, params: rental_data
      }.must_differ "Rental.count", 0

      must_respond_with :not_found
    end

    it "prevents check in if video does not exist" do
      rental_data[:video_id] = nil

      expect {
        post check_out_path, params: rental_data
      }.must_differ "Rental.count", 0

      must_respond_with :not_found
    end
  end
  
end
