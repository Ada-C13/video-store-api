require "test_helper"

describe CustomersController do
  CUSTOMER_KEYS = ["id", "name", "registered_at", "postal_code", "phone", "videos_checked_out_count"].sort
  
  describe CustomersController do
    it "responds with JSON and success" do
      # Act
      get customers_path

      # Assert
      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with :ok
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
