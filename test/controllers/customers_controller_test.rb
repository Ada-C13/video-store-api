require "test_helper"

describe CustomersController do

  REQUIRED_CUSTOMER_FIELDS = [:id, :name, :registered_at, :postal_code, :phone, :videos_checkout_out_count].sort

  describe "index" do
    it "responds with JSON and success" do
      # Act 
      get customers_path
      
      # Assert
      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with :ok
    end

    it "responds with an array of Customer hashes" do
      # Act 
      get customers_path

      # Get the body of the response
      body = JSON.parse(response.body)

      # Assert
      expect(body).must_be_instance_of Array

      body.each do |customer|
        expect(customer).must_be_instance_of Hash
        expect(customer.keys.sort).must_be REQUIRED_CUSTOMER_FIELDS
      end
    end
    
    it "will respond with an empty array when there are no Customers" do
      # Arrange
      Customer.destroy_all

      # Act
      get customers_path
      body = JSON.parse(response.body)

      # Assert
      expect(body).must_be_instance_of Array
      expect(body).must_equal []
    end 
  end
end
