require "test_helper"

describe RentalsController do
  describe "check_out" do 

    let(:customer) {
      customers(:junito)
    }
    
    let(:video) {
      videos(:brazil)
    }
    
    
    it "can get checkout path" do 
      post check_out_path(customer_id: customer.id, video_id: video.id)
      must_respond_with :success
      expect(response.header['Content-Type']).must_include 'json'
    end 
    
    
    
  end 
  
  describe "check_in" do 
    
  end 
end
