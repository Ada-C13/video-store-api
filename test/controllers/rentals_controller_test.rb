require "test_helper"

describe RentalsController do

  REQUIRED_ATTRS = ["customer_id", "video_id", "due_date"].sort
  CHECKIN_ATTR = ["customer_id", "video_id", "videos_checked_out_count", "available_inventory"].sort

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
      # puts "BEFORE CHECKOUT: #{customers(:customer_one).videos_checked_out_count}"
      # puts Rental.count
      # new_customer = Customer.create(
      #   name: "New Customer",
      #   registered_at: "Wed, 29 Apr 2015 07:54:14 -0700",
      #   address: "Main Street",
      #   city: "Seattle",
      #   state: "WA",
      #   postal_code: "98116a",
      #   phone: "(436)4276232",
      #   videos_checked_out_count: 5,
      # )

      # new_video = Video.create(
      #   title: "New Video",
      #   overview: "Testing a new video",
      #   release_date: "2010-04-22",
      #   total_inventory: 5,
      #   available_inventory: 4
      # )

      # parameters = {
      #   rental: {
      #     customer_id: new_customer.id,
      #     video_id: new_video.id,
      #   }
      # }
      customer_before_video_count = customers(:customer_one).videos_checked_out_count
      videos_before_available_count = videos(:fake_vid).available_inventory

      expect {
        post check_out_path, params: check_out_data
      }.must_differ "Rental.count", 1

      expect(customers(:customer_one).videos_checked_out_count).must_equal (customer_before_video_count + 1)
      expect(videos(:fake_vid).available_inventory).must_equal (videos_before_available_count - 1)

      # puts "AFTER CHECKOUT: #{customers(:customer_one).videos_checked_out_count}"
      # puts Rental.count

      # expect(customers(:customer_one).videos_checked_out_count).must_equal 2
      # expect(videos(:fake_vid).available_inventory).must_equal 6

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
    let(:check_in_data) {
      {
        rental: {
          customer_id: customers(:customer_one).id,
          video_id: videos(:fake_vid).id,
        }
      }
    }

    it "Successfully checks in a rental" do 
      customer = customers(:customer_one)
      customer.videos_checked_out_count = 2
      customer.save

      video = videos(:fake_vid)
      video.available_inventory = 7
      video.save

      expect{
        post check_in_path, params: check_in_data
      }.wont_change "Rental.count"

      must_respond_with :ok 

      expect(customers(:customer_one).videos_checked_out_count).must_equal 1
      expect(videos(:fake_vid).available_inventory).must_equal 8

      body = JSON.parse(response.body)
      expect(body).must_be_instance_of Hash
      expect(body.keys.sort).must_equal CHECKIN_ATTR
    end

    it "Will respond with not_found if customer is not found" do 
      check_in_data[:rental][:customer_id] = nil 

      expect {
        post check_in_path, params: check_in_data
      }.wont_change "Rental.count"

      must_respond_with :not_found

      expect(response.header['Content-Type']).must_include 'json'
      body = JSON.parse(response.body)
      expect(body["errors"]).must_equal 'Customer does not exist.'
    end

    it "Will respond with not_found if video is not found" do
      check_in_data[:rental][:video_id] = nil 
      
      expect {
        post check_in_path, params: check_in_data
      }.wont_change "Rental.count"

      must_respond_with :not_found

      expect(response.header['Content-Type']).must_include 'json'
      body = JSON.parse(response.body)
      expect(body["errors"]).must_equal 'Video does not exist.'
    end

  end
end
