require "test_helper"

describe Customer do
  
  describe 'validations' do
    before do
      @customer = customers(:junito)
    end
    
    it 'is invalid without a name' do
      @customer.name = ''
      
      expect(@customer.valid?).must_equal false
      expect(@customer.errors.messages).must_include :name
    end
    
    it 'is invalid without a postal code' do
      @customer.postal_code = ''
      
      expect(@customer.valid?).must_equal false
      expect(@customer.errors.messages).must_include :postal_code
    end
    
    it 'is invalid without an address' do
      @customer.address = ''
      
      expect(@customer.valid?).must_equal false
      expect(@customer.errors.messages).must_include :address
    end
    
    it 'is invalid without a city' do
      @customer.city = ''
      
      expect(@customer.valid?).must_equal false
      expect(@customer.errors.messages).must_include :city
    end
    
    it 'is invalid without a state' do
      @customer.state = ''
      
      expect(@customer.valid?).must_equal false
      expect(@customer.errors.messages).must_include :state
    end
    
    it 'is invalid without a phone number' do
      @customer.phone = ''
      
      expect(@customer.valid?).must_equal false
      expect(@customer.errors.messages).must_include :phone
    end
    
    it 'is invalid without a videos_checked_out_count' do
      @customer.videos_checked_out_count = ''
      
      expect(@customer.valid?).must_equal false
      expect(@customer.errors.messages).must_include :videos_checked_out_count
    end
    
    #TODO:  Add validation for integer - also for positive integer
    # it 'is invalid if videos_checked_out_count is not an integer' do
    #   @customer.videos_checked_out_count = 'empanada'
    
    #   expect(@customer.valid?).must_equal false
    #   expect(@customer.errors.messages).must_include :videos_checked_out_count
    # end
  end
  
end