require "test_helper"

describe CustomersController do
  REQUIRED_CUSTOMER_FIELDS = ["id", "name", "address", "city", "state", "postal_code", "phone", "registered_at"].sort

  def check_response(expected_type:, expected_status: :success)
    must_respond_with expected_status
    expect(response.header["Content-Type"]).must_include "json"

    body = JSON.parse(response.body)
    expect(body).must_be_kind_of expected_type
    return body
  end

  describe "index" do
    it "responds with JSON and success" do
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
  

  describe "show" do
    # Nominal case
    it "will return a hash with the proper fields for an existing customer" do
      customer = customers(:customer_1)

      get customers_path(customer.id)
      # act
      must_respond_with :success

      body = JSON.parse(response.body)[0]

      expect(response.header["Content-Type"]).must_include "json"

      expect(body).must_be_instance_of Hash
      expect(body.keys.sort).must_equal ["address", "city", "id", "name", "phone","postal_code", "registered_at","state"]
    end
    
    it "will return a 404 request with json for a non-existent customer" do
      get customer_path(-1)
      must_respond_with :not_found
      body = JSON.parse(response.body)
      expect(body).must_be_instance_of Hash
      expect(body["errors"]).must_equal ["Not Found"]
    end
  end
end
