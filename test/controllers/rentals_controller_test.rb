 require "test_helper"

describe RentalsController do

  describe "checkout" do
    before do 
    customer = Customer.first
    video = Video.first
   
    @rental_data = {
          customer_id: customer.id,
          video_id: video.id,
          due_date: Date.today + 7.days
    }
    end

    it "responds with JSON and success" do
      post check_out_path, params: @rental_data

      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with :ok
    end
 
    it "responds with id" do
      post check_out_path, params: @rental_data
      body = JSON.parse(response.body)
    
      expect(body).must_be_instance_of Hash
      expect(body[:id]).is_a? Integer
    end



    # it "return detailed errors and 400: Bad Request if no available inventory before check out" do
    #   @rental_data.video.available_inventory = nil

    #   post check_out_path, params: @rental_data

    #   expect(response.header['Content-Type']).must_include 'json'
    #   must_respond_with :not_found
    # end



    
  
    # it "can assign a checkout_date and change available_inventory and videos_checked_out_count" do
    #   video_rental = Rental.find_by(video_id: video.id)
    #   inventory = video_rental.available_inventory
    #   # checked_out_count = Rental.last.customer.videos_checked_out_count

    #   post check_out_path, params: @rental_data
      
    #   body = JSON.parse(response.body)
    #   must_respond_with :ok
    #   rental = Rental.find_by(customer_id: body["customer_id"])
    #   p "111111111111111111 #{body}"
    #   expect(rental.video.available_inventory).must_equal (inventory - 1)
    #   # expect(body["due_date"]).must_equal Date.today + 7.days
      
    #   # expect(rbody["videos_checked_out_count"]).must_equal (checked_out_count - 1)
    # end

    it "will respond with bad_request for invalid video" do
      
      @rental_data[:video_id] = nil
      expect {
        post check_out_path, params: @rental_data
      }.wont_change "Rental.count"
      
      must_respond_with :not_found
      expect(response.header['Content-Type']).must_include 'json'
      body = JSON.parse(response.body)
      expect(body["errors"]).must_equal ["Not Found"]
    end

    it "will respond with bad_request for invalid customer" do
      
      @rental_data[:customer_id] = nil
      expect {
        post check_out_path, params: @rental_data
      }.wont_change "Rental.count"
      
      must_respond_with :not_found
      expect(response.header['Content-Type']).must_include 'json'
      body = JSON.parse(response.body)
      expect(body["errors"]).must_equal ["Not Found"]
    end
    
  end

  describe "checkin" do 
    before do 
      @video = videos(:video2)
      @customer = Customer.first
      @rental_data = {
        video_id: @video.id, 
        customer_id: @customer.id
      }
    end

    it "can assign a checkin_date and change available_inventory and videos_checked_out_count" do
      post check_out_path, params: @rental_data
      
      inventory = Rental.last.video.available_inventory
      checked_out_count = Rental.last.customer.videos_checked_out_count
      
      expect {
        post check_in_path, params: @rental_data
      }.wont_change 'Rental.count'
      
      body = JSON.parse(response.body)
      must_respond_with :ok
      rental = Rental.find_by(customer_id: body["customer_id"])
      expect(rental.video.available_inventory).must_equal (inventory + 1)
      expect(rental.checked_in).must_equal Date.today
      
      expect(rental.customer.videos_checked_out_count).must_equal (checked_out_count - 1)
    end
    
    it "will respond with bad_request for invalid video" do
      
      @rental_data[:video_id] = nil
      expect {
        post check_in_path, params: @rental_data
      }.wont_change "Rental.count"

      must_respond_with :not_found
      expect(response.header['Content-Type']).must_include 'json'
      body = JSON.parse(response.body)
      expect(body["errors"]).must_equal ["Not Found"]
    end

    it "will respond with bad_request for invalid customer" do
      
      @rental_data[:customer_id] = nil
      expect {
        post check_in_path, params: @rental_data
      }.wont_change "Rental.count"

      must_respond_with :not_found
      expect(response.header['Content-Type']).must_include 'json'
      body = JSON.parse(response.body)
      expect(body["errors"]).must_equal ["Not Found"]
    end
  end
end


