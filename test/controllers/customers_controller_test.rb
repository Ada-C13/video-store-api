require "test_helper"

describe CustomersController do
  CUSTOMER_KEYS = ["id", "name", "registered_at", "address", "city", "state", "postal_code", "phone", "videos_checked_out_count"].sort
  # it "does a thing" do
  #   value(1+1).must_equal 2
  # end
  describe CustomersController do
    it "responds with JSON and success" do
      get customers_path
  
      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with :ok
    end
  
    it "responds with an array of customer hashes" do
      # Act
      get customers_path
  
      body = JSON.parse(response.body)
  
      # Assert
      expect(body).must_be_instance_of Array
      body.each do |customer|
        expect(customer).must_be_instance_of Hash
        # required_cust_attrs = ["id", "name", "phone", "postal_code", "registered_at", "videos_checked_out_count"]
  
        expect(customer.keys.sort).must_equal CUSTOMER_KEYS
      end
    end
  
    it "will respond with an empty array when there are no customers" do
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
