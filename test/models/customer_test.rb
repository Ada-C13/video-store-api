require "test_helper"

describe Customer do
  describe "relations" do
    let(:customer) { customers(:customer) }
    let(:video) {videos(:video2)}
    let(:video2) {videos(:video3)}
    
    it "can have many rentals" do
      Rental.create(video_id: video.id, customer_id: customer.id, due_date: Date.yesterday)
      Rental.create(video_id: video2.id, customer_id: customer.id, due_date: Date.today)
      
      expect(customer.rentals.length).must_equal 2
    end
    
    it "can have zero rentals" do
      customer_two = customers(:customer)
      
      expect(customer_two.rentals.length).must_equal 0
    end
  end
  
  describe "validations" do
    before do 
      @customer = Customer.create(name: "Some Name", registered_at: "Mon, 14 Jun 2019 18:09:04 -0700", address: "Some house North Avenue", city: "Kirkland", state: "Wa", postal_code: "98034", phone: "(521) 124-5753")
    end
    
    it "is valid when all fields are present" do
      
      expect(@customer.valid?).must_equal true
    end
    
    it "is not valid if name is not present" do 
      @customer.name = nil
      
      expect(@customer.valid?).must_equal false
    end
    
    it "is not valid if postal code is not present" do 
      @customer.postal_code = nil
      
      expect(@customer.valid?).must_equal false
    end
    
    it "is not valid if phone is not present" do 
      @customer.phone = nil
      
      expect(@customer.valid?).must_equal false
    end
    
    #registered_at
    it "is not valid if registered_at is not present" do 
      @customer.registered_at = nil
      
      expect(@customer.valid?).must_equal false
    end
  end
end