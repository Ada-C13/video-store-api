require "test_helper"

describe Customer do
  before do
    @customer = customers(:charli)
  end
  
  describe 'validations' do
    it "has required fields" do
      result = @customer.valid?
      expect(result).must_equal true
    end
    
    it "must fail if nil" do
      @customer.name = nil
      expect(@customer.valid?).must_equal false
    end
  end
end