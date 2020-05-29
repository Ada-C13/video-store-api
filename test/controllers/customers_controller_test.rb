require "test_helper"

describe CustomersController do
  REQUIRED_CUSTOMER_FIELDS = [
    "id",
    "name",
    "registered_at",
    "postal_code",
    "phone",
    "videos_checked_out_count"
  ].sort

  describe "index" do
    it "must get index" do
      get customers_path
      check_response(expected_type: Array)
    end

    it "responds with an array of customer hashes" do
      # Act
      get customers_path

      # Assert
      body = check_response(expected_type: Array)
      body.each do |customer|
        expect(customer).must_be_instance_of Hash
        expect(customer.keys.sort).must_equal REQUIRED_CUSTOMER_FIELDS
      end
    end

    it "will respond with an empty array when there are no customers" do
      # Arrange
      Customer.destroy_all

      # Act
      get customers_path

      # Assert
      body = check_response(expected_type: Array)
      expect(body).must_equal []
    end
  end

end
