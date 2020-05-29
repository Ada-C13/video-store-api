require "test_helper"

describe Rental do
  
  describe 'validations' do
    it 'can be created' do
      customer = customers(:junito)
      video = videos(:brazil)
      
      rental = Rental.create(customer_id: customer.id, video_id: video.id, due_date: Date.today)
      
      expect(rental.valid?).must_equal true
      
    end
    
    it "can't be created without customer" do
      customer_id = 'taco'
      video = videos(:brazil)
      
      rental = Rental.create(customer_id: customer_id, video_id: video.id, due_date: Date.today)
      
      expect(rental.valid?).must_equal false
      expect(rental.errors.messages).must_include :customer
    end
    
    it "can't be created without video" do
      customer = customers(:junito)
      video_id = 'apple'
      
      rental = Rental.create(customer_id: customer.id, video_id: video_id, due_date: Date.today)
      
      expect(rental.valid?).must_equal false
      expect(rental.errors.messages).must_include :video
    end
    
    it "can't be created without due_date" do
      customer = customers(:junito)
      video = videos(:brazil)
      
      rental = Rental.create(customer_id: customer.id, video_id: video.id, due_date: nil)
      
      expect(rental.valid?).must_equal false
      expect(rental.errors.messages).must_include :due_date
    end
    
  end
end
