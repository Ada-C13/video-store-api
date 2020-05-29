require "test_helper"

describe Customer do
  describe "validations" do 
    before do 
      @customer = customers(:kiayada)
    end 

    it "is valid when name is present" do 
      result = @customer.valid? 

      expect(result).must_equal true 

    end 

    it "is not valid if customer name is nil" do 
      @customer.name = nil 
      result = @customer.valid?

      expect(result).must_equal false 
      expect(@customer.errors).wont_be_empty  
      expect(@customer.errors.messages[:name].include?("can't be blank") ).must_equal true 
    end 

  end 
end
