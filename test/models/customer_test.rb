require "test_helper"

describe Customer do
  before do
    @customer = customers(:shelley)
  end

  it "can be instantiated" do
    # Arrange
    new_customer = Customer.new(
      name: "Test",
      registered_at: "2015-04-29T14:54:14.000Z",
      address: "Ap 292",
      city: "Hills",
      state: "OR",
      postal_code: "24309",
      phone: "(322) 510-8695",
      videos_checked_out_count: 1
      )
    new_customer.save
    # Assert
    expect(Customer.last).must_equal new_customer
  end

  it "has the required fields" do
    # Arrange
    @customer

    # Assert
    [:id, :name, :registered_at, :postal_code, :phone, :videos_checked_out_count].each do |f|
      
      # Assert
      expect(@customer).must_respond_to f
    end

    expect(@customer.created_at).wont_be_nil
  end

  describe 'validations' do
    it "is valid when all fields are filled" do
      result = @customer.valid?
      expect(result).must_equal true
    end

    it 'fails validation when name, registered_at, postal_code, phone or check out videos are nil' do
      new_customer = Customer.new(
        address: "Ap 292",
        city: "Hills",
        state: "OR",
        )
      new_customer.save
  
      expect(new_customer.valid?).must_equal false

      [:name, :registered_at, :postal_code, :phone, :videos_checked_out_count].each do |f|
      # Assert
        expect(new_customer.errors.messages.include?(f)).must_equal true
        expect(new_customer.errors.messages[f].include?("can't be blank")).must_equal true
      end
    end
  end
end
