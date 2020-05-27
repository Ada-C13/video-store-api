require "test_helper"

describe RentalsController do
  let(:customer){
    customers(:customer1)
  }
  let(:video){
    videos(:video1)
  }
  let(:rental){
    {
    customer_id: customer.id,
    movie_id: video.id,
    }
  }

  describe "checkout" do
    it ""do
    end
    it "" do 
    end
  end

  describe "checkin" do
  end
end
