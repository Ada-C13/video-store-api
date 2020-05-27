require "test_helper"

describe Customer do
  describe "validations" do 
    before do
      @customer = customers(:shelley)
    end

    it "is valid when all the fields are present" do
      result = @customer.valid?
      expect(result).must_equal true
    end

    it "is invalid when name is missing" do 
      @customer.name = nil

      result = @customer.valid?
      expect(result).must_equal false
      expect(@customer.errors.messages).must_include :name
    end

    it "is invalid when registered_at is missing" do
      @customer.registered_at = nil

      result = @customer.valid?
      expect(result).must_equal false 
      expect(@customer.errors.messages).must_include :registered_at
    end

    it "is invalid when address is missing" do
      @customer.address = nil

      result = @customer.valid?
      expect(result).must_equal false
      expect(@customer.errors.messages).must_include :address
    end

    it "is invalid when city is missing" do
      @customer.city = nil

      result = @customer.valid?
      expect(result).must_equal false 
      expect(@customer.errors.messages).must_include :city
    end

    it "is invalid when state is missing" do 
      @customer.city = nil

      result = @customer.valid?
      expect(result).must_equal false 
      expect(@customer.errors.messages).must_include :city
    end

    it "is invalid when postal code is missing" do 
      @customer.postal_code = nil

      result = @customer.valid?
      expect(result).must_equal false 
      expect(@customer.errors.messages).must_include :postal_code
    end

    it "is invalid when phone is missing" do 
      @customer.phone = nil

      result = @customer.valid?
      expect(result).must_equal false 
      expect(@customer.errors.messages).must_include :phone
    end
  end
end
