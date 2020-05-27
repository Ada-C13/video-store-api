require "test_helper"

describe Customer do
 let(:customer) { customers(:Jane) }

  describe "validations" do
    it "is valid when all required fields are present" do
      expect(customer.valid?).must_equal true
    end

    it "is invalid with a field is missing" do
      customer.name = nil
      expect(customer.valid?).must_equal false
    end
  end
end
