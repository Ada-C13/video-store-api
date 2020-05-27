require "test_helper"

describe RentalsController do

  let (:rental_data) {


  }
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
      
      #must_respond_with :created
      
      
    end 
  end   
end
