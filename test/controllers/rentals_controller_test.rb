require "test_helper"

describe RentalsController do
  describe "checkin" do
    before do

    end
    it "will check in a valid customer" do

    end

    it "will give back the appropriate details in json" do

    end

    it "will add 1 to the Video's inventory and subtract 1 from Customer's rentals" do

    end

    it "will return a 404 status and error message with an invalid Customer" do

    end

    it "will return a 404 status and error message with an invalid Video" do

    end
  end

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

      customer = Customer.first
      video = Video.first
      

      rental_data = {
        customer_id: customer.id, 
        video_id: video.id
      } 

      

      expect{post check_out_path, params: rental_data}.wont_change "Rental.count"

      must_respond_with :bad_request  

      body = JSON.parse(response.body)
      expect(body["errors"]).must_include "No available inventory from video"

    end 
  end   

end
