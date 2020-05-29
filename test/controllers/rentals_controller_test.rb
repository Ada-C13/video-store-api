require "test_helper"

describe RentalsController do
  describe "check-in" do
    before do
      @customer = customers(:kiayada)
      @video = videos(:testvideo)

      @rental_params = {
        customer_id: @customer.id,
        video_id: @video.id
      }

      @rental = Rental.create!(customer_id: @customer.id, video_id: @video.id)
    end
    it "will check in a valid customer" do

      post check_in_path, params: @rental_params

      must_respond_with :ok
      expect(response.header['Content-Type']).must_include 'json'
    end

    it "will give back the appropriate details in json" do
      post check_in_path, params: @rental_params

      body = JSON.parse(response.body)

      expect(body).must_be_instance_of Hash
      expect(body.keys.sort).must_equal ["available_inventory", "customer_id", "video_id", "videos_checked_out_count"].sort
    end

    it "will add 1 to the Video's inventory and subtract 1 from Customer's rentals" do
      customer = Customer.last
      video = Video.last

      rental_data = {
        customer_id: customer.id ,
        video_id: video.id
      } 
      p customer 
      post check_in_path, params: rental_data

      p Customer.find_by(id:customer.id)
      expect{post check_in_path, params: rental_data}.must_differ "Customer.last.videos_checked_out_count", -1

 
    end

    it "will return a 404 status and error message with an invalid Customer" do
      bad_params = @rental_params
      bad_params[:customer_id] = -5
      video = Video.find_by(id: bad_params[:video_id])

      post check_in_path, params: bad_params

      must_respond_with :not_found

      body = JSON.parse(response.body)

      expect(body["errors"]).must_include "Not Found"

      current_inv = Video.find_by(id: bad_params[:video_id]).available_inventory
      expect(video.available_inventory).must_equal current_inv
    end

    it "will return a 404 status and error message with an invalid Video" do
      bad_params = @rental_params
      bad_params[:video_id] = -5
      cust = Customer.find_by(id: bad_params[:customer_id])

      post check_in_path, params: bad_params

      must_respond_with :not_found

      body = JSON.parse(response.body)

      expect(body["errors"]).must_include "Not Found"

      checked_out = Customer.find_by(id: bad_params[:customer_id]).videos_checked_out_count
      expect(cust.videos_checked_out_count).must_equal checked_out
    end
  end

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  describe 'checkout' do 
    it "will create a rental" do

      customer = Customer.first
      video = Video.first

      rental_data = {
        customer_id: customer.id ,
        video_id: video.id
      } 

      expect{post check_out_path, params: rental_data}.must_differ "Rental.count", 1 

      must_respond_with :ok
    end

    it "will change customer and video fields in data when check out" do 
      # customer video_checked_out 2 , video available is 2 
      customer = Customer.first
      video = Video.first

      rental_data = {
        customer_id: customer.id ,
        video_id: video.id
      } 

      expect{post check_out_path, params: rental_data}.must_differ "Customer.first.videos_checked_out_count", 1

     

    end 

    it "will return 404 if customer doen't exist and errors details" do 

      customer = Customer.first
      video = Video.first

      rental_data = {
        customer_id: -1, 
        video_id: video.id
      } 

      expect{post check_out_path, params: rental_data}.wont_change "Rental.count"
      
      must_respond_with :not_found 

      body = JSON.parse(response.body)
      expect(body["errors"]).must_include "Not Found"

    end 

    it "will return bad_request if video has 0 inventory" do 
      # skip
      customer = Customer.first
      video = Video.first
      

      rental_data = {
        customer_id: customer.id, 
        video_id: video.id
      } 

      video.available_inventory = 0 

      expect{post check_out_path, params: rental_data}.wont_change "Rental.count"

      must_respond_with :bad_request  

      body = JSON.parse(response.body)
      expect(body["errors"]).must_include "No available inventory from video"

    end 
  end   

end
