require "test_helper"

describe RentalsController do
  describe "check out" do 

    it "will create a rental" do 
      customer = customers(:shelley)
      customer.save 
      video = videos(:vid1)
      video.save 

      rental_data = {
          customer_id: customer.id, 
          video_id: video.id
      }
    
      expect {
        post check_out_path, params: rental_data
      }.must_differ "Rental.count", 1
      
      must_respond_with :created
    end 

    it "will not check out if there are no available videos" do 
      customer = customers(:shelley)
      customer.save 
      video = videos(:vid3)
      video.save 

      rental_data = {
        customer_id: customer.id, 
        video_id: video.id
      }

      expect {
        post check_out_path, params: rental_data
      }.must_differ "Rental.count", 0

      must_respond_with :bad_request

      body = JSON.parse(response.body) 

      expect(body).must_be_instance_of Hash
      expect(body["errors"]).must_equal "No Inventory Available"
    end 

    it "will have the correct due date" do 
      customer = customers(:shelley)
      customer.save 
      video = videos(:vid1)
      video.save 

      rental_data = {
        customer_id: customer.id, 
        video_id: video.id
      }
      expect {
        post check_out_path, params: rental_data
      }.must_differ "Rental.count", 1
      rental = Rental.first

      expect(rental.due_date.to_s).must_include "2020"
    end 
  end   
end
