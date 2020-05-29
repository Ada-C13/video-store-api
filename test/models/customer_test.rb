require "test_helper"

describe Customer do
 let(:customer) { customers(:Jane) }

  describe "validations" do
    it "is valid when all required fields are present" do
      expect(customer.valid?).must_equal true
    end

    it "is invalid when name is missing" do
      customer.name = nil
      expect(customer.valid?).must_equal false
    end
    
    it "is invalid when address is missing" do
      customer.address = nil
      expect(customer.valid?).must_equal false
    end

    it "is invalid when name is missing" do
      customer.city = nil
      expect(customer.valid?).must_equal false
    end

    it "is invalid when name is missing" do
      customer.state = nil
      expect(customer.valid?).must_equal false
    end

    it "is invalid when name is missing" do
      customer.postal_code = nil
      expect(customer.valid?).must_equal false
    end

    it "is invalid when name is missing" do
      customer.phone = nil
      expect(customer.valid?).must_equal false
    end


  end
end