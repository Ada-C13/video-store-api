require "test_helper"

describe RentalsController do
  describe "check-out" do
    CHECKOUT_RENTAL_FIELDS = ["customer_id", "video_id", "due_date", "videos_checked_out_count", "available_inventory"].sort
    
    it "should change Rental count" do
      customer = customers(:jessica)
      video = videos(:toystory)
      
      expect {
        post checkout_path, params: {customer_id: customer.id, video_id: video.id}
      }.must_differ "Rental.count", 1
    end

    it "should respond with success and return json with correct fields if customer and video are valid" do
      customer = customers(:jessica)
      video = videos(:toystory)
      
      post checkout_path, params: {customer_id: customer.id, video_id: video.id}

      body = JSON.parse(response.body)

      expect(body.keys.sort).must_equal CHECKOUT_RENTAL_FIELDS
      must_respond_with :success
      expect(response.header['Content-Type']).must_include 'json'
    end

    it "renders not found json if customer is invalid" do
      video = videos(:toystory)
      
      post checkout_path, params: {customer_id: -1, video_id: video.id}

      body = JSON.parse(response.body)
      expect(body['errors']).must_include 'Not Found'
      must_respond_with :not_found
    end

    it "renders not found json if video is invalid" do
      customer = customers(:jessica)
      
      post checkout_path, params: {customer_id: customer.id, video_id: -1}

      body = JSON.parse(response.body)
      expect(body['errors']).must_include 'Not Found'
      must_respond_with :not_found
    end

    it "renders no videos in stock error message and bad request if no videos in stock" do
      customer = customers(:jessica)
      video = videos(:toystory)

      video.available_inventory = 0
      video.save
      
      post checkout_path, params: {customer_id: customer.id, video_id: video.id}

      body = JSON.parse(response.body)
      expect(body['errors']).must_include 'No videos in stock'
      must_respond_with :bad_request
    end

  end

  describe "check-in" do
    CHECKIN_RENTAL_FIELDS = ["customer_id", "video_id", "videos_checked_out_count", "available_inventory"].sort
    
    it "should respond with success and return json with correct fields if customer and video are valid" do
      customer = customers(:jessica)
      video = videos(:toystory)
      
      post checkin_path, params: {customer_id: customer.id, video_id: video.id}

      body = JSON.parse(response.body)

      expect(body.keys.sort).must_equal CHECKIN_RENTAL_FIELDS
      must_respond_with :success
      expect(response.header['Content-Type']).must_include 'json'
    end

    it "renders not found json if customer is invalid" do
      video = videos(:toystory)
      
      post checkin_path, params: {customer_id: -1, video_id: video.id}

      body = JSON.parse(response.body)
      expect(body['errors']).must_include 'Not Found'
      must_respond_with :not_found
    end

    it "renders not found json if video is invalid" do
      customer = customers(:jessica)
      
      post checkin_path, params: {customer_id: customer.id, video_id: -1}

      body = JSON.parse(response.body)
      expect(body['errors']).must_include 'Not Found'
      must_respond_with :not_found
    end

  end

end
