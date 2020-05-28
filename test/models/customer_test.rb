require "test_helper"

describe Customer do
  describe "validations" do 
    it "is valid when name is present" do 
      # Act
      result = customers(:shelley).valid?

      # Assert
      expect(result).must_equal true
    end 

    it "is not valid when name is absent" do 
    # Arrange
    invalid_customer = Customer.new(name: nil)

    # Act
    result = invalid_customer.valid?
  
    # Assert
    expect(result).must_equal false
    expect(invalid_customer.errors.messages).must_include :name
    end 

    it "is not valid when phone number is absent" do 
      # Arrange
      invalid_customer = Customer.new(name: "Tom", phone: nil)

      # Act
      result = invalid_customer.valid?
    
      # Assert
      expect(result).must_equal false
      expect(invalid_customer.errors.messages).must_include :phone
    end 
  end
end
