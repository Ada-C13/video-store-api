require "test_helper"

describe Customer do
  describe "validations" do
    let(:customer_data) {
      {
        customer: {
          name: "Nataliya",
          registered_at: "Wed, 29 Apr 2015 14:54:14 UTC +00:00",
          address: "13133 111th Dr Se",
          city: "Monroe",
          state: "WA",
          postal_code: "98989",
          phone: "425 425 44 44",
          videos_checked_out_count: 3
        }
      }
    }

    it "is valid when all fields are present" do
      customer = Customer.new(customer_data[:customer])
      expect(customer.valid?).must_equal true
    end

    it "is invalid without a name" do
      customer_data[:customer][:name] = nil
      customer = Customer.new(customer_data[:customer])
      expect(customer.valid?).must_equal false
    end

    it "is invalid without registered_at" do
      customer_data[:customer][:registered_at] = nil
      customer = Customer.new(customer_data[:customer])
      expect(customer.valid?).must_equal false
    end

    it "is invalid without an address" do
      customer_data[:customer][:address] = nil
      customer = Customer.new(customer_data[:customer])
      expect(customer.valid?).must_equal false
    end

    it "is invalid without a city" do
      customer_data[:customer][:city] = nil
      customer = Customer.new(customer_data[:customer])
      expect(customer.valid?).must_equal false
    end

    it "is invalid without a state" do
      customer_data[:customer][:state] = nil
      customer = Customer.new(customer_data[:customer])
      expect(customer.valid?).must_equal false
    end

    it "is invalid without a postal_code" do
      customer_data[:customer][:postal_code] = nil
      customer = Customer.new(customer_data[:customer])
      expect(customer.valid?).must_equal false
    end

    it "is invalid without a phone" do
      customer_data[:customer][:phone] = nil
      customer = Customer.new(customer_data[:customer])
      expect(customer.valid?).must_equal false
    end

    it "is invalid without videos_checked_out_count" do
      customer_data[:customer][:videos_checked_out_count] = nil
      customer = Customer.new(customer_data[:customer])
      expect(customer.valid?).must_equal false
    end

    it "videos_checked_out_count should be integer 0 or larger" do
      customer_data[:customer][:videos_checked_out_count] = "I don't know"
      customer = Customer.new(customer_data[:customer])
      expect(customer.valid?).must_equal false

      customer_data[:customer][:videos_checked_out_count] = -1
      customer = Customer.new(customer_data[:customer])
      expect(customer.valid?).must_equal false

      customer_data[:customer][:videos_checked_out_count] = 0
      customer = Customer.new(customer_data[:customer])
      expect(customer.valid?).must_equal true
    end
  end
end
